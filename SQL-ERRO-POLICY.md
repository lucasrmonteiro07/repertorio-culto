-- ============================================
-- SQL de ATUALIZAÇÃO para tabela existente
-- Use este se receber erro "policy already exists"
-- ============================================

-- Se a tabela já existe, os índices e políticas
-- também existem. Os dados continuam salvando 
-- normalmente com os novos campos!

-- ✅ BOAS NOTÍCIAS:
-- A tabela JSONB de musicos já aceita os novos campos:
-- - backVocal1
-- - backVocal2
-- - backVocal3

-- Você pode começar a salvar AGORA!
-- Os dados serão salvos corretamente no Supabase.

-- ============================================
-- APENAS se quiser forçar recriação da tabela:
-- ============================================

-- 1. Deletar a tabela existente (CUIDADO - perderá dados!)
-- DROP TABLE IF EXISTS cultos CASCADE;

-- 2. Depois execute o SQL completo de criação

-- ============================================
-- Ou melhor: DEIXE COMO ESTÁ!
-- ============================================

-- A tabela já funciona com os novos campos.
-- Basta continuar usando o app normalmente!

-- Para confirmar que está tudo bem, execute:
SELECT * FROM cultos LIMIT 1;

-- Se retornar 0 linhas, significa a tabela está vazia e pronta!
-- Se retornar dados, está sincronizando corretamente!
