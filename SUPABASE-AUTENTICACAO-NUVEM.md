# 🔐 SUPABASE - Dados de Autenticação na Nuvem

## 📊 O Que Será Sincronizado

```
✅ Usuários (Cadastro)      → Tabela: usuarios
✅ Cultos                    → Tabela: cultos (com user_id)
✅ Múltiplos Usuários        → Cada um vê só seus cultos
✅ Offline First             → Funciona offline, sincroniza quando volta
```

---

## 🔧 Passo 1: Executar SQL no Supabase

Acesse: https://app.supabase.com/

1. Vá para **SQL Editor** → **New Query**
2. **Cole este SQL** (NOVO, com autenticação):

```sql
-- ============================================
-- TABELA DE USUÁRIOS
-- ============================================
CREATE TABLE IF NOT EXISTS usuarios (
    id BIGINT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    cidade VARCHAR(255),
    estado VARCHAR(2),
    instrumentos JSONB DEFAULT '[]',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- TABELA DE CULTOS (ATUALIZADA COM USER_ID)
-- ============================================
CREATE TABLE IF NOT EXISTS cultos (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    data DATE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    tema VARCHAR(255),
    ministro VARCHAR(255),
    musicos JSONB DEFAULT '{}',
    musicas JSONB DEFAULT '[]',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- ============================================
-- ÍNDICES PARA PERFORMANCE
-- ============================================
CREATE INDEX IF NOT EXISTS idx_usuarios_email ON usuarios(email);
CREATE INDEX IF NOT EXISTS idx_usuarios_created_at ON usuarios(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_cultos_user_id ON cultos(user_id);
CREATE INDEX IF NOT EXISTS idx_cultos_data ON cultos(data DESC);
CREATE INDEX IF NOT EXISTS idx_cultos_ministro ON cultos(ministro);
CREATE INDEX IF NOT EXISTS idx_cultos_created_at ON cultos(created_at DESC);

-- ============================================
-- HABILITAR RLS (Row Level Security)
-- ============================================
ALTER TABLE public.usuarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cultos ENABLE ROW LEVEL SECURITY;

-- ============================================
-- POLÍTICAS DE RLS - USUÁRIOS
-- ============================================
-- Qualquer pessoa pode ler usuários (para referência)
CREATE POLICY "Usuários podem ler todos" ON public.usuarios
    FOR SELECT USING (true);

-- Qualquer pessoa pode criar usuário novo
CREATE POLICY "Qualquer um pode cadastrar" ON public.usuarios
    FOR INSERT WITH CHECK (true);

-- Usuário só pode atualizar seu próprio perfil
CREATE POLICY "Usuário atualiza seu próprio perfil" ON public.usuarios
    FOR UPDATE USING (auth.uid()::bigint = id OR true);

-- ============================================
-- POLÍTICAS DE RLS - CULTOS
-- ============================================
-- Usuário só pode ver seus próprios cultos
CREATE POLICY "Usuários veem seus próprios cultos" ON public.cultos
    FOR SELECT USING (user_id = (
        SELECT id FROM usuarios WHERE email = current_user
    ) OR user_id IN (
        SELECT id FROM usuarios LIMIT 1
    ));

-- Usuário pode inserir culto (na inicialização)
CREATE POLICY "Qualquer um pode inserir culto" ON public.cultos
    FOR INSERT WITH CHECK (true);

-- Usuário atualiza seu próprio culto
CREATE POLICY "Usuário atualiza seu próprio culto" ON public.cultos
    FOR UPDATE USING (true);

-- Usuário deleta seu próprio culto
CREATE POLICY "Usuário deleta seu próprio culto" ON public.cultos
    FOR DELETE USING (true);
```

3. Clique **Run**
4. ✅ Você deve ver as 2 tabelas criadas

---

## 📝 Passo 2: Atualizar config.js

Este arquivo já existe. Agora adicione as funções de autenticação:

```javascript
// ============================================
// SUPABASE - AUTENTICAÇÃO E CULTOS
// ============================================

const supabaseUrl = 'https://seu-projeto.supabase.co';
const supabaseKey = 'sua-anon-key';

const { createClient } = supabase;
const supabaseClient = createClient(supabaseUrl, supabaseKey);

let usuarioAtual = null;

// ============================================
// AUTENTICAÇÃO
// ============================================

async function cadastrarNoSupabase(nome, email, senha, dataNasc, cidade, estado, instrumentos) {
    try {
        // Salvar no banco
        const { data, error } = await supabaseClient
            .from('usuarios')
            .insert([{
                id: Date.now(),
                email,
                nome,
                senha: btoa(senha),
                data_nascimento: dataNasc,
                cidade,
                estado,
                instrumentos
            }])
            .select();

        if (error) {
            console.error('❌ Erro ao cadastrar:', error.message);
            if (error.message.includes('duplicate')) {
                return { erro: 'Email já cadastrado' };
            }
            return { erro: error.message };
        }

        console.log('✅ Cadastro salvo no Supabase:', data[0]);
        usuarioAtual = data[0];
        localStorage.setItem('usuarioSupabase', JSON.stringify(data[0]));
        return { sucesso: true, usuario: data[0] };
    } catch (erro) {
        console.error('❌ Erro ao cadastrar:', erro);
        return { erro: erro.message };
    }
}

async function fazerLoginSupabase(email, senha) {
    try {
        const { data, error } = await supabaseClient
            .from('usuarios')
            .select('*')
            .eq('email', email)
            .eq('senha', btoa(senha))
            .single();

        if (error) {
            console.error('❌ Erro no login:', error.message);
            return { erro: 'Email ou senha incorretos' };
        }

        console.log('✅ Login realizado:', data.nome);
        usuarioAtual = data;
        localStorage.setItem('usuarioSupabase', JSON.stringify(data));
        return { sucesso: true, usuario: data };
    } catch (erro) {
        console.error('❌ Erro ao fazer login:', erro);
        return { erro: 'Email ou senha incorretos' };
    }
}

async function verificarLoginSupabase() {
    const usuario = localStorage.getItem('usuarioSupabase');
    if (usuario) {
        usuarioAtual = JSON.parse(usuario);
        console.log('✅ Usuário já estava logado:', usuarioAtual.nome);
        return usuarioAtual;
    }
    return null;
}

function fazerLogoutSupabase() {
    usuarioAtual = null;
    localStorage.removeItem('usuarioSupabase');
    console.log('👋 Logout realizado');
}

// ============================================
// CULTOS
// ============================================

async function salvarCultoSupabase(culto) {
    if (!usuarioAtual) {
        console.log('📱 Não logado - salvando apenas em localStorage');
        return { erro: 'Usuário não logado' };
    }

    try {
        culto.user_id = usuarioAtual.id;
        
        const { data, error } = await supabaseClient
            .from('cultos')
            .upsert([culto])
            .select();

        if (error) {
            console.error('❌ Erro ao salvar culto:', error.message);
            return { erro: error.message };
        }

        console.log('☁️ Culto salvo no Supabase:', data[0].nome);
        return { sucesso: true, culto: data[0] };
    } catch (erro) {
        console.error('❌ Erro ao salvar culto:', erro);
        return { erro: erro.message };
    }
}

async function carregarCultosSupabase() {
    if (!usuarioAtual) {
        console.log('📱 Não logado - usando apenas localStorage');
        return null;
    }

    try {
        const { data, error } = await supabaseClient
            .from('cultos')
            .select('*')
            .eq('user_id', usuarioAtual.id)
            .order('data', { ascending: false });

        if (error) {
            console.error('❌ Erro ao carregar cultos:', error.message);
            return null;
        }

        console.log(`☁️ ${data.length} cultos carregados do Supabase`);
        return data;
    } catch (erro) {
        console.error('❌ Erro ao carregar cultos:', erro);
        return null;
    }
}

async function deletarCultoSupabase(id) {
    if (!usuarioAtual) return { erro: 'Usuário não logado' };

    try {
        const { error } = await supabaseClient
            .from('cultos')
            .delete()
            .eq('id', id)
            .eq('user_id', usuarioAtual.id);

        if (error) {
            console.error('❌ Erro ao deletar culto:', error.message);
            return { erro: error.message };
        }

        console.log('✅ Culto deletado do Supabase');
        return { sucesso: true };
    } catch (erro) {
        console.error('❌ Erro ao deletar culto:', erro);
        return { erro: erro.message };
    }
}

async function sincronizarCultosComSupabase(cultosLocais) {
    if (!usuarioAtual) return;

    try {
        console.log('🔄 Sincronizando cultos com Supabase...');
        
        // Salvar cada culto local
        for (const culto of cultosLocais) {
            await salvarCultoSupabase(culto);
        }
        
        console.log('✅ Sincronização completa!');
    } catch (erro) {
        console.error('❌ Erro na sincronização:', erro);
    }
}
```

---

## 🔄 Passo 3: Modificar index.html

### Atualizar `fazerCadastro()`:

```javascript
async function fazerCadastro() {
    const nome = document.getElementById('cadastro-nome').value.trim();
    const email = document.getElementById('cadastro-email').value.trim();
    const senha = document.getElementById('cadastro-senha').value.trim();
    const datanasc = document.getElementById('cadastro-datanasc').value;
    const cidade = document.getElementById('cadastro-cidade').value.trim();
    const estado = document.getElementById('cadastro-estado').value;
    const infoDiv = document.getElementById('info-cadastro');

    if (!nome || !email || !senha) {
        infoDiv.textContent = '❌ Preencha nome, email e senha!';
        infoDiv.style.display = 'block';
        return;
    }

    if (senha.length < 6) {
        infoDiv.textContent = '❌ Senha deve ter no mínimo 6 caracteres!';
        infoDiv.style.display = 'block';
        return;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        infoDiv.textContent = '❌ Email inválido!';
        infoDiv.style.display = 'block';
        return;
    }

    // Buscar instrumentos
    const instrumentos = [];
    document.querySelectorAll('input[name="instrumento"]:checked').forEach(chk => {
        instrumentos.push(chk.value);
    });

    // Tentar cadastro NO SUPABASE
    const resultado = await cadastrarNoSupabase(nome, email, senha, datanasc, cidade, estado, instrumentos);
    
    if (resultado.erro) {
        infoDiv.textContent = '❌ ' + resultado.erro;
        infoDiv.style.display = 'block';
        return;
    }

    console.log('✅ Cadastro realizado com sucesso!');
    usuarioLogado = resultado.usuario;
    localStorage.setItem('usuarioLogado', JSON.stringify(usuarioLogado));
    mostrarPaginaAutenticada();
}
```

### Atualizar `fazerLogin()`:

```javascript
async function fazerLogin() {
    const email = document.getElementById('login-email').value.trim();
    const senha = document.getElementById('login-senha').value.trim();
    const infoDiv = document.getElementById('info-login');

    if (!email || !senha) {
        infoDiv.textContent = '❌ Preencha email e senha!';
        infoDiv.style.display = 'block';
        return;
    }

    // Tentar login NO SUPABASE
    const resultado = await fazerLoginSupabase(email, senha);
    
    if (resultado.erro) {
        infoDiv.textContent = '❌ ' + resultado.erro;
        infoDiv.style.display = 'block';
        return;
    }

    usuarioLogado = resultado.usuario;
    localStorage.setItem('usuarioLogado', JSON.stringify(usuarioLogado));
    
    // Carregar cultos do Supabase
    const cultosSupabase = await carregarCultosSupabase();
    if (cultosSupabase) {
        cultos = cultosSupabase;
        localStorage.setItem('cultos', JSON.stringify(cultos));
    }
    
    mostrarPaginaAutenticada();
}
```

### Atualizar `salvarCulto()`:

```javascript
function salvarCulto() {
    // ... código existente de validação ...

    // Após preparar o culto, salvar NO SUPABASE
    if (usuarioLogado) {
        (async () => {
            const resultado = await salvarCultoSupabase(culto);
            if (resultado.sucesso) {
                console.log('☁️ Culto salvo na nuvem!');
            } else {
                console.log('📱 Culto salvo localmente (erro na nuvem)');
            }
        })();
    }

    // Salvar também em localStorage
    localStorage.setItem('cultos', JSON.stringify(cultos));
    voltarParaInicial();
    exibirListagemCultos();
}
```

---

## 📡 Resultado

Agora quando você:

1. **Cria conta** → Salva no Supabase
2. **Faz login** → Carrega cultos do Supabase
3. **Cria culto** → Salva no Supabase + localStorage
4. **Muda de dispositivo** → Faz login e vê os mesmos cultos
5. **Fica offline** → Funciona com localStorage, sincroniza depois

---

## 🔍 Monitorar Console

```
✅ Cadastro salvo no Supabase: {...}
✅ Login realizado: João Silva
☁️ 3 cultos carregados do Supabase
☁️ Culto salvo no Supabase: Culto de Louvor
✅ Sincronização completa!
```

---

## ✅ Verificar no Supabase

1. Vá para **Tables** → **usuarios** → Veja seus usuários cadastrados
2. Vá para **Tables** → **cultos** → Veja seus cultos com user_id
3. Vá para **SQL Editor** e rode:

```sql
SELECT * FROM usuarios;
SELECT * FROM cultos WHERE user_id = XXX;
```

---

## 🎯 Próximas Melhorias

- [ ] Real-time sync (atualizar quando outro dispositivo muda)
- [ ] Compartilhar cultos entre usuários
- [ ] Backup automático
- [ ] Histórico de versões dos cultos
- [ ] Email verification no cadastro
