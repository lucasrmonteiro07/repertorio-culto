// Configuração Supabase para ADORAI APP
const SUPABASE_CONFIG = {
    url: 'https://neunjwqcgttnjbzvfaga.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ldW5qd3FjZ3R0bmpienZmYWdhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE3NTIyNzksImV4cCI6MjA3NzMyODI3OX0.gvXEGfBmRcUzMOdBFCifitpUaPUVW_IxV4bg3j78Dyw',
    serviceKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ldW5qd3FjZ3R0bmpienZmYWdhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MTc1MjI3OSwiZXhwIjoyMDc3MzI4Mjc5fQ.0xy2HUFVErkkLJKdzaKM5Ns2ozwrHU_Zcr_OmhVoV8E'
};

// Inicializar cliente Supabase
let supabaseClient = null;

async function initSupabase() {
    if (!supabaseClient && window.supabase) {
        supabaseClient = window.supabase.createClient(
            SUPABASE_CONFIG.url,
            SUPABASE_CONFIG.anonKey
        );
        console.log('✅ Supabase inicializado com sucesso!');
    }
    return supabaseClient;
}

// Status de sincronização
const syncStatus = {
    isOnline: navigator.onLine,
    isSyncing: false,
    lastSync: null,
    pendingChanges: 0
};

// Monitorar conexão
window.addEventListener('online', () => {
    syncStatus.isOnline = true;
    console.log('🟢 Online - Sincronizando dados...');
    syncPendingChanges();
    updateSyncIndicator();
});

window.addEventListener('offline', () => {
    syncStatus.isOnline = false;
    console.log('🔴 Offline - Dados salvos localmente');
    updateSyncIndicator();
});

function updateSyncIndicator() {
    const indicator = document.getElementById('sync-indicator');
    if (!indicator) return;

    if (syncStatus.isSyncing) {
        indicator.innerHTML = '⏳ Sincronizando...';
        indicator.style.color = '#ffc107';
    } else if (syncStatus.isOnline) {
        indicator.innerHTML = '🟢 Online';
        indicator.style.color = '#00bcd4';
    } else {
        indicator.innerHTML = '🔴 Offline';
        indicator.style.color = '#f44336';
    }
}

// Sincronizar mudanças pendentes
async function syncPendingChanges() {
    if (!syncStatus.isOnline || syncStatus.isSyncing) return;

    const pending = JSON.parse(localStorage.getItem('pendingSync') || '[]');
    if (pending.length === 0) return;

    syncStatus.isSyncing = true;
    updateSyncIndicator();

    const supabase = await initSupabase();
    if (!supabase) {
        syncStatus.isSyncing = false;
        updateSyncIndicator();
        return;
    }

    for (const change of pending) {
        try {
            if (change.type === 'insert') {
                await supabase.from('cultos').insert([change.data]);
            } else if (change.type === 'update') {
                await supabase.from('cultos')
                    .update(change.data)
                    .eq('id', change.data.id);
            }
            console.log('✅ Sincronizado:', change.data.id);
        } catch (error) {
            console.error('❌ Erro ao sincronizar:', error);
        }
    }

    localStorage.removeItem('pendingSync');
    syncStatus.isSyncing = false;
    syncStatus.lastSync = new Date();
    updateSyncIndicator();
}

// Salvar com sincronização automática
async function saveToSupabase(culto) {
    if (!syncStatus.isOnline) {
        // Offline: apenas salvar localmente
        console.log('📱 Offline - Salvando apenas localmente');
        savePendingChange('insert', culto);
        return { success: true, offline: true };
    }

    const supabase = await initSupabase();
    if (!supabase) {
        savePendingChange('insert', culto);
        return { success: true, offline: true };
    }

    try {
        syncStatus.isSyncing = true;
        updateSyncIndicator();

        // Verificar se já existe
        const { data: existing } = await supabase
            .from('cultos')
            .select('id')
            .eq('id', culto.id)
            .single();

        let result;
        if (existing) {
            // Update
            result = await supabase
                .from('cultos')
                .update(culto)
                .eq('id', culto.id);
        } else {
            // Insert
            result = await supabase
                .from('cultos')
                .insert([culto]);
        }

        if (result.error) {
            throw result.error;
        }

        console.log('☁️ Sincronizado com Supabase:', culto.id);
        syncStatus.lastSync = new Date();
        syncStatus.isSyncing = false;
        updateSyncIndicator();

        return { success: true, online: true };
    } catch (error) {
        console.error('❌ Erro ao salvar online:', error);
        savePendingChange('insert', culto);
        syncStatus.isSyncing = false;
        updateSyncIndicator();
        return { success: true, offline: true, error };
    }
}

// Registrar mudança pendente
function savePendingChange(type, data) {
    const pending = JSON.parse(localStorage.getItem('pendingSync') || '[]');
    pending.push({ type, data, timestamp: new Date().toISOString() });
    localStorage.setItem('pendingSync', JSON.stringify(pending));
    syncStatus.pendingChanges = pending.length;
    console.log(`⏳ Mudança pendente registrada (total: ${syncStatus.pendingChanges})`);
}

// Carregar cultos do Supabase
async function loadCultosFromSupabase() {
    const supabase = await initSupabase();
    if (!supabase || !syncStatus.isOnline) {
        console.log('📱 Usando dados locais (offline ou Supabase indisponível)');
        return null;
    }

    try {
        const { data, error } = await supabase
            .from('cultos')
            .select('*')
            .order('data', { ascending: false });

        if (error) throw error;

        console.log(`☁️ ${data?.length || 0} cultos carregados do Supabase`);
        return data;
    } catch (error) {
        console.error('❌ Erro ao carregar Supabase:', error);
        return null;
    }
}
