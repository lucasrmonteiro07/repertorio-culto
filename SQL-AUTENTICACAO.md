# 🔐 SQL - Sistema de Autenticação e Músicos

## 📝 Execute este SQL no Supabase Editor

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
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- TABELA DE MÚSICOS (COM INSTRUMENTOS)
-- ============================================
CREATE TABLE IF NOT EXISTS musicos (
    id BIGINT PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    instrumentos JSONB DEFAULT '[]',
    ativo BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- ============================================
-- ÍNDICES PARA PERFORMANCE
-- ============================================
CREATE INDEX IF NOT EXISTS idx_usuarios_email ON usuarios(email);
CREATE INDEX IF NOT EXISTS idx_usuarios_created_at ON usuarios(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_musicos_usuario_id ON musicos(usuario_id);
CREATE INDEX IF NOT EXISTS idx_musicos_ativo ON musicos(ativo);

-- ============================================
-- HABILITAR RLS
-- ============================================
ALTER TABLE public.usuarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.musicos ENABLE ROW LEVEL SECURITY;

-- ============================================
-- POLÍTICAS DE RLS - USUÁRIOS
-- ============================================
CREATE POLICY "Usuários podem ver todos" ON public.usuarios
    FOR SELECT USING (true);

CREATE POLICY "Usuários podem inserir" ON public.usuarios
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Usuários podem atualizar seu próprio perfil" ON public.usuarios
    FOR UPDATE USING (true);

-- ============================================
-- POLÍTICAS DE RLS - MÚSICOS
-- ============================================
CREATE POLICY "Músicos podem ser lidos" ON public.musicos
    FOR SELECT USING (true);

CREATE POLICY "Músicos podem ser inseridos" ON public.musicos
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Músicos podem ser atualizados" ON public.musicos
    FOR UPDATE USING (true);

CREATE POLICY "Músicos podem ser deletados" ON public.musicos
    FOR DELETE USING (true);

-- ============================================
-- ADICIONAR COLUNA user_id À TABELA cultos
-- ============================================
ALTER TABLE public.cultos ADD COLUMN IF NOT EXISTS user_id BIGINT;
ALTER TABLE public.cultos ADD COLUMN IF NOT EXISTS musicos_selecionados JSONB DEFAULT '{}';

-- Index para performance
CREATE INDEX IF NOT EXISTS idx_cultos_user_id ON cultos(user_id);

-- ============================================
-- LISTA DE INSTRUMENTOS DISPONÍVEIS
-- ============================================
-- Usar como referência:
-- [
--   { nome: "Baixo", selecionado: false },
--   { nome: "Guitarra", selecionado: false },
--   { nome: "Violão", selecionado: false },
--   { nome: "Teclado", selecionado: false },
--   { nome: "Bateria", selecionado: false },
--   { nome: "Sopro", selecionado: false },
--   { nome: "Back Vocal 1", selecionado: false },
--   { nome: "Back Vocal 2", selecionado: false },
--   { nome: "Back Vocal 3", selecionado: false }
-- ]
```

---

## ✅ Estrutura de Dados

### Usuários
```json
{
  "id": 1730246400000,
  "email": "usuario@exemplo.com",
  "nome": "João Silva",
  "senha": "[criptografada]",
  "data_nascimento": "1990-05-15",
  "cidade": "São Paulo",
  "estado": "SP",
  "created_at": "2024-10-29T10:00:00Z"
}
```

### Músicos
```json
{
  "id": 1730246400001,
  "usuario_id": 1730246400000,
  "nome": "Pedro Santos",
  "instrumentos": [
    "Baixo",
    "Guitarra"
  ],
  "ativo": true,
  "created_at": "2024-10-29T10:05:00Z"
}
```

### Cultos (com referência de usuário)
```json
{
  "id": 1730246400002,
  "user_id": 1730246400000,
  "data": "2024-10-29",
  "nome": "Culto de Louvor",
  "tema": "Jesus Cristo",
  "ministro": "Pastor João",
  "musicos_selecionados": {
    "baixo": {
      "musico_id": 1730246400001,
      "nome": "Pedro Santos",
      "instrumentos": ["Baixo", "Guitarra"]
    },
    "guitarra": {
      "musico_id": 1730246400003,
      "nome": "Lucas Oliveira",
      "instrumentos": ["Guitarra"]
    }
  },
  "musicas": [],
  "created_at": "2024-10-29T10:10:00Z"
}
```

---

## 🚀 Como Usar

1. **Copie o SQL acima**
2. Vá para **SQL Editor** no Supabase
3. Clique em **"New Query"**
4. **Cole o SQL**
5. Clique em **"Run"**
6. Você verá as 2 novas tabelas: `usuarios` e `musicos`

---

## 📱 Flow do App

```
TELA INICIAL (Sem usuário)
    ↓
LOGIN ou CADASTRO
    ↓
DASHBOARD (Após autenticação)
    ├─ Gerenciar Meus Músicos
    ├─ Criar Culto
    └─ Listar Cultos (com filtro de músicos)
```
