-- ============================================
-- ADORAI APP - SQL Completo com Back Vocals
-- Copie e cole no Supabase SQL Editor
-- ============================================

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

-- Função para atualizar timestamp (updated_at)
CREATE OR REPLACE FUNCTION atualizar_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar updated_at automaticamente
DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON cultos;
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE ON cultos
    FOR EACH ROW
    EXECUTE FUNCTION atualizar_updated_at();

-- ============================================
-- FIM DO SCRIPT
-- ============================================
-- Estrutura de um culto com back vocals:
-- {
--     "id": 1730246400000,
--     "data": "2024-10-29",
--     "nome": "Culto de Louvor",
--     "tema": "Jesus Cristo",
--     "ministro": "Pastor João",
--     "musicos": {
--         "baixo": "Pedro",
--         "guitarra": "João",
--         "violao": "Lucas",
--         "teclado": "Maria",
--         "bateria": "Ana",
--         "sopro": "Carlos",
--         "backVocal1": "Sofia",
--         "backVocal2": "Gabriela",
--         "backVocal3": "Juliana"
--     },
--     "musicas": [...]
-- }
-- ============================================
