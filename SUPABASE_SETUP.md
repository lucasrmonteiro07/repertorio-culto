# 📊 Setup Supabase - ADORAI APP

## 🔧 Passo 1: Executar SQL no Supabase Editor

Acesse seu projeto Supabase em: https://app.supabase.com/

1. Vá para **SQL Editor**
2. Clique em **"New Query"**
3. Cole o SQL abaixo:

```sql
-- Tabela: cultos
CREATE TABLE IF NOT EXISTS cultos (
    id BIGINT PRIMARY KEY,
    data DATE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    tema VARCHAR(255),
    ministro VARCHAR(255),
    musicos JSONB DEFAULT '{}',
    musicas JSONB DEFAULT '[]',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_cultos_data ON cultos(data DESC);
CREATE INDEX IF NOT EXISTS idx_cultos_ministro ON cultos(ministro);
CREATE INDEX IF NOT EXISTS idx_cultos_created_at ON cultos(created_at DESC);

-- Habilitar RLS (Row Level Security)
ALTER TABLE public.cultos ENABLE ROW LEVEL SECURITY;

-- Política: Todos podem ler
CREATE POLICY "Ler cultos" ON public.cultos
    FOR SELECT USING (true);

-- Política: Todos podem inserir
CREATE POLICY "Inserir cultos" ON public.cultos
    FOR INSERT WITH CHECK (true);

-- Política: Todos podem atualizar
CREATE POLICY "Atualizar cultos" ON public.cultos
    FOR UPDATE USING (true);

-- Política: Todos podem deletar
CREATE POLICY "Deletar cultos" ON public.cultos
    FOR DELETE USING (true);
```

4. Clique em **"Run"**

---

## ✅ Verificar Criação

Depois de executar:
1. Vá para **Tables** no sidebar esquerdo
2. Você deve ver a tabela `cultos` criada
3. Clique nela para ver as colunas

---

## 🚀 Usar no App

O app está pronto para usar! Agora quando você:

- **Salvar um culto** → É salvo localmente E sincronizado com Supabase
- **Ficar offline** → Salva localmente, sincroniza quando voltar online
- **Carregar a página** → Busca os cultos do Supabase (se online)

---

## 📡 Teste Online/Offline

### Para testar OFFLINE:
1. Abra DevTools (F12)
2. Vá para **Network**
3. Clique em **"Offline"** (dropdown)
4. Salve um culto
5. Veja a mensagem "🔴 Offline" no canto superior direito

### Para voltar ONLINE:
1. Clique em **"Offline"** → selecione um tipo de rede
2. Dados sincronizam automaticamente

---

## 🔍 Monitorar Sincronização

Abra o Console (F12) para ver logs como:
- `✅ Supabase inicializado com sucesso!`
- `☁️ Sincronizado com Supabase: 1730246400000`
- `📱 Offline - Salvando apenas localmente`
- `🟢 Online` ou `🔴 Offline`

---

## 📋 Estrutura dos Dados

Cada culto salvo tem:
```json
{
    "id": 1730246400000,
    "data": "2024-10-29",
    "nome": "Culto de Louvor",
    "tema": "Jesus Cristo",
    "ministro": "Pastor João",
    "musicos": {
        "baixo": "Pedro",
        "guitarra": "João",
        "violao": "Lucas",
        "teclado": "Maria",
        "bateria": "Ana",
        "sopro": "Carlos",
        "backVocal1": "Sofia",
        "backVocal2": "Gabriela",
        "backVocal3": "Juliana"
    },
    "musicas": [
        {
            "nome": "Graça Maior",
            "tom_original": "C",
            "tom_desejado": "G",
            "cifrasOriginais": "[C] [Am]",
            "cifrasTranspostas": "[G] [Em]",
            "youtube": "...",
            "spotify": "...",
            "bpm": "120",
            ...
        }
    ]
}
```

---

## 🆘 Troubleshooting

**P: Erro "policy already exists"?**
- ✅ **BOA NOTÍCIA!** Sua tabela já está criada!
- Você pode **ignorar esse erro** e começar a usar normalmente
- Os novos campos (backVocal1, backVocal2, backVocal3) já funcionam
- A tabela JSONB é flexível e aceita novos campos automaticamente
- Veja `SQL-ERRO-POLICY.md` para mais detalhes

**P: Dados não sincronizam?**
- Verifique se está online (canto superior direito)
- Cheque console (F12) para erros
- Verifique se as credenciais no `config.js` estão corretas

**P: Erro "Tabela não encontrada"?**
- Execute o SQL acima no Supabase SQL Editor
- Verifique se está no banco correto

**P: Quer limpar tudo?**
- Limpar localStorage: `localStorage.clear()`
- Deletar tabela no Supabase: ir a **Tables** → clicar em cultos → **Delete table**
- Depois execute o SQL novamente

---

## 📱 Testado em:
- ✅ Desktop (Chrome, Firefox, Safari)
- ✅ Mobile (iOS Safari, Chrome Android)
- ✅ Online e Offline
- ✅ Múltiplos usuários (compartilham mesmos dados)
