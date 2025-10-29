-- ============================================
-- ADORAI APP - Schema Supabase
-- Tabelas para sincronização de cultos
-- ============================================

-- Tabela: cultos
-- Armazena todos os cultos com informações gerais
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

-- Tabela: sincronizacao_log (opcional, para rastrear sincronizações)
CREATE TABLE IF NOT EXISTS sincronizacao_log (
    id BIGSERIAL PRIMARY KEY,
    culto_id BIGINT REFERENCES cultos(id) ON DELETE CASCADE,
    tipo_operacao VARCHAR(50), -- insert, update, delete
    timestamp_sincronizacao TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    status VARCHAR(50) -- sucesso, erro
);

-- ============================================
-- Políticas de Segurança (RLS)
-- ============================================

-- Habilitar RLS
ALTER TABLE cultos ENABLE ROW LEVEL SECURITY;
ALTER TABLE sincronizacao_log ENABLE ROW LEVEL SECURITY;

-- Política: Qualquer usuário pode ler
CREATE POLICY "Todos podem ler cultos" ON cultos
    FOR SELECT USING (true);

-- Política: Usuários podem inserir seus próprios cultos
CREATE POLICY "Usuários podem inserir cultos" ON cultos
    FOR INSERT WITH CHECK (true);

-- Política: Usuários podem atualizar cultos
CREATE POLICY "Usuários podem atualizar cultos" ON cultos
    FOR UPDATE USING (true);

-- Política: Usuários podem deletar cultos
CREATE POLICY "Usuários podem deletar cultos" ON cultos
    FOR DELETE USING (true);

-- ============================================
-- Função para atualizar timestamp (updated_at)
-- ============================================

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
-- Exemplo de dados (comentado)
-- ============================================
/*
INSERT INTO cultos (id, data, nome, tema, ministro, musicos, musicas)
VALUES (
    1730246400000,
    '2024-10-29',
    'Culto de Louvor',
    'Jesus Cristo',
    'Pastor João',
    '{"guitarra":"João","teclado":"Maria"}',
    '[{"nome":"Graça Maior","tom_original":"C","tom_desejado":"G","cifras":"[C] [Am]"}]'
);
*/
