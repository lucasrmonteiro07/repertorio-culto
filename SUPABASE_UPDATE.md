# 🔄 Atualizar Supabase - ADORAI APP

## Se você JÁ tem a tabela `cultos` criada

Se você já executou o SQL anterior e quer adicionar os **Back Vocals**, não precisa fazer nada especial!

A tabela usa **JSONB** para armazenar os `musicos`, então ela já é **totalmente flexível** e aceita novos campos automaticamente.

### ✅ A tabela já suporta:
- `backVocal1`
- `backVocal2`
- `backVocal3`

Os dados serão salvos normalmente sem precisar alterar o schema!

---

## 🆕 Se você AINDA NÃO criou a tabela

Execute este SQL **completo** no Supabase SQL Editor:

### 📌 SQL Completo com Back Vocals

```sql
-- ============================================
-- Tabela: cultos (VERSÃO COMPLETA)
-- ============================================
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

-- Políticas de segurança
CREATE POLICY "Ler cultos" ON public.cultos
    FOR SELECT USING (true);

CREATE POLICY "Inserir cultos" ON public.cultos
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Atualizar cultos" ON public.cultos
    FOR UPDATE USING (true);

CREATE POLICY "Deletar cultos" ON public.cultos
    FOR DELETE USING (true);

-- Função para atualizar timestamp
CREATE OR REPLACE FUNCTION atualizar_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar updated_at
DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON cultos;
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE ON cultos
    FOR EACH ROW
    EXECUTE FUNCTION atualizar_updated_at();
```

---

## 📝 Exemplo de dados com Back Vocals

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
    "musicas": [...]
}
```

---

## 🔍 Verificar se já existe

Antes de executar, verifique se a tabela já existe:

### No Supabase Dashboard:
1. Clique em **Tables** (sidebar esquerdo)
2. Procure por `cultos`
3. Se não existir, execute o SQL acima
4. Se existir, não precisa fazer nada! ✅

### Via SQL (para confirmar):
```sql
SELECT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_name = 'cultos'
);
```

Se retornar `true`, a tabela já existe! ✅

---

## 🚀 Próximos Passos

1. **Salve um culto no app** com back vocals preenchidos
2. **F12 → Console** para ver logs de sincronização
3. **Vá ao Supabase Dashboard** → **Tables** → **cultos** → **Data**
4. Veja os dados salvos lá! 🎉

---

## 🆘 Troubleshooting

**P: Erro "Table already exists"?**
- Use `CREATE TABLE IF NOT EXISTS` (já está no SQL acima)
- Ou delete a tabela e recrie

**P: Dados não aparecem no Supabase?**
- Verifique se está online (canto superior direito da app)
- Abra F12 → Console para ver erros
- Verifique as credenciais em `config.js`

**P: Quer limpar tudo?**
```sql
-- Deletar a tabela
DROP TABLE cultos CASCADE;

-- Depois execute o SQL acima novamente
```

---

## 📊 Campos da tabela `cultos`

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `id` | BIGINT | ID único (timestamp) |
| `data` | DATE | Data do culto |
| `nome` | VARCHAR | Nome do culto |
| `tema` | VARCHAR | Tema do culto |
| `ministro` | VARCHAR | Ministro responsável |
| `musicos` | JSONB | Objeto com todos os músicos (6 + 3 back vocals) |
| `musicas` | JSONB | Array de músicas |
| `created_at` | TIMESTAMP | Data de criação |
| `updated_at` | TIMESTAMP | Data de última atualização |

---

## 💡 Campos de `musicos` (JSONB)

```json
{
    "baixo": "string",
    "guitarra": "string",
    "violao": "string",
    "teclado": "string",
    "bateria": "string",
    "sopro": "string",
    "backVocal1": "string",
    "backVocal2": "string",
    "backVocal3": "string"
}
```

Todos opcionais! Se não preenchido, deixa vazio.

---

## ✅ Tudo pronto!

A app já está salvando com back vocals. Basta executar este SQL no Supabase e começar a salvar! 🚀
