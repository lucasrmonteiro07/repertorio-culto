# 📋 SQL PARA ATUALIZAR NO SUPABASE

## 🚀 PASSO-A-PASSO RÁPIDO

### 1️⃣ Acesse Supabase
```
https://app.supabase.com/
```

### 2️⃣ Vá para SQL Editor
- Clique em **SQL Editor** (sidebar esquerdo)
- Clique em **"New Query"**

### 3️⃣ Cole este SQL:

```sql
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

CREATE INDEX IF NOT EXISTS idx_cultos_data ON cultos(data DESC);
CREATE INDEX IF NOT EXISTS idx_cultos_ministro ON cultos(ministro);
CREATE INDEX IF NOT EXISTS idx_cultos_created_at ON cultos(created_at DESC);

ALTER TABLE public.cultos ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Ler cultos" ON public.cultos
    FOR SELECT USING (true);

CREATE POLICY "Inserir cultos" ON public.cultos
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Atualizar cultos" ON public.cultos
    FOR UPDATE USING (true);

CREATE POLICY "Deletar cultos" ON public.cultos
    FOR DELETE USING (true);

CREATE OR REPLACE FUNCTION atualizar_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON cultos;
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE ON cultos
    FOR EACH ROW
    EXECUTE FUNCTION atualizar_updated_at();
```

### 4️⃣ Clique em **RUN**

### 5️⃣ Pronto! ✅

---

## 📱 Agora você tem:

- ✅ **6 músicos básicos**: Baixo, Guitarra, Violão, Teclado, Bateria, Sopro
- ✅ **3 Back Vocals**: Back Vocal 1, Back Vocal 2, Back Vocal 3
- ✅ **Sincronização automática** entre app e Supabase
- ✅ **Online/Offline support** (salva offline, sincroniza depois)
- ✅ **Responsividade mobile** (340px até desktop)

---

## 🎯 Campos de `musicos`:

```json
{
    "baixo": "Pedro",
    "guitarra": "João",
    "violao": "Lucas",
    "teclado": "Maria",
    "bateria": "Ana",
    "sopro": "Carlos",
    "backVocal1": "Sofia",
    "backVocal2": "Gabriela",
    "backVocal3": "Juliana"
}
```

---

## 🔄 Já tem a tabela?

Se você JÁ criou a tabela anterior, **não precisa fazer nada**!

A tabela usa JSONB, então os novos campos `backVocal1`, `backVocal2`, `backVocal3` já funcionam automaticamente.

Basta começar a usar! 🚀

---

## 📌 Arquivos de Referência

- `SUPABASE_SETUP.md` - Guia completo de setup inicial
- `SUPABASE_UPDATE.md` - Guia detalhado com troubleshooting
- `sql-completo-back-vocals.sql` - Arquivo SQL puro
- Este arquivo - Quick reference visual

---

## ✨ Pronto!

Agora salve um culto e veja os dados aparecerem no Supabase! 🎉
