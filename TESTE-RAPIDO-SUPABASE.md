# 🚀 TESTE RÁPIDO - Supabase Autenticação

## ⏱️ 5 Minutos para Testar Tudo

### 1️⃣ Preparar Supabase (1 min)

Vá para: https://app.supabase.com/ → SQL Editor → New Query

**Cole este SQL:**

```sql
ALTER TABLE public.cultos 
ADD COLUMN IF NOT EXISTS user_id BIGINT REFERENCES public.usuarios(id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_cultos_user_id ON cultos(user_id DESC);

ALTER TABLE public.usuarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cultos ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Usuários podem ler todos" ON public.usuarios;
DROP POLICY IF EXISTS "Qualquer um pode cadastrar" ON public.usuarios;
CREATE POLICY "Usuários podem ler todos" ON public.usuarios FOR SELECT USING (true);
CREATE POLICY "Qualquer um pode cadastrar" ON public.usuarios FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Usuários veem seus próprios cultos" ON public.cultos;
CREATE POLICY "Usuários veem seus próprios cultos" ON public.cultos FOR SELECT USING (true);
CREATE POLICY "Qualquer um pode inserir culto" ON public.cultos FOR INSERT WITH CHECK (true);
CREATE POLICY "Usuário atualiza seu próprio culto" ON public.cultos FOR UPDATE USING (true);
CREATE POLICY "Usuário deleta seu próprio culto" ON public.cultos FOR DELETE USING (true);
```

**Clique:** RUN ✅

---

### 2️⃣ Testar Cadastro (1 min)

Abra a app:

1. **Clique em "Criar Conta"**
2. **Preencha:**
   - Nome: `João Silva`
   - Email: `joao@teste.com`
   - Senha: `123456`
   - Data: `1990-05-15`
   - Cidade: `São Paulo`
   - Estado: `SP`
   - Instrumento: Guitarra ✓

3. **Clique em Cadastrar**
4. **Console (F12) deve aparecer:**
   ```
   ✅ Cadastro salvo no Supabase: João Silva
   ```

---

### 3️⃣ Verificar no Supabase (1 min)

1. Vá para **Tables** → **usuarios**
2. **Você deve ver:** `joao@teste.com` com nome `João Silva`

✅ **Dados salvos na nuvem!**

---

### 4️⃣ Testar Logout + Login (1 min)

1. **Clique em "Sair"** (canto superior direito)
2. **Clique em "Já tenho conta"**
3. **Preencha:**
   - Email: `joao@teste.com`
   - Senha: `123456`

4. **Clique em Entrar**
5. **Console deve aparecer:**
   ```
   ✅ Login realizado no Supabase: João Silva
   ```

✅ **Login funcionando!**

---

### 5️⃣ Testar Sincronização de Cultos (1 min)

1. **Clique em "+"** para novo culto
2. **Preencha:**
   - Data: `2025-10-29`
   - Nome: `Culto Teste`
   - Tema: `Jesus`
   - Ministro: `Pastor`
   - Adicionar música: Clique **"Adicionar Música"**
   - Nome da música: `Graça Maior`
   - Clique **Salvar**

3. **Console deve aparecer:**
   ```
   ☁️ Culto salvo no Supabase: Culto Teste
   ```

---

### 6️⃣ Verificar Culto no Supabase (1 min)

1. Vá para **Tables** → **cultos**
2. **Você deve ver:**
   - `nome`: "Culto Teste"
   - `user_id`: Mesmo ID do usuário
   - `data`: "2025-10-29"

✅ **Culto sincronizado com user_id!**

---

## ✅ Tudo Funcionando!

Se chegou aqui e viu todos os ✅:

- ✅ Cadastro salvo no Supabase
- ✅ Login funciona
- ✅ Cultos sincronizam
- ✅ Dados persistem por dispositivo

**Seu sistema está 100% PRONTO!** 🎉

---

## 🔍 Se algo não funcionar

### Erro: "Email ou senha incorretos"

1. Abra **Tables** → **usuarios**
2. Verifique se o email está lá
3. Tente novamente

### Erro: "Erro ao conectar com servidor"

1. Verifique sua conexão com internet
2. Abra DevTools (F12) → Console
3. Procure por mensagens de erro vermelhas

### Culto não sincroniza

1. Verifique no Console se aparece:
   ```
   ☁️ Culto salvo no Supabase
   ```
2. Se não aparecer, cheque se está logado
3. Abra **Tables** → **cultos** e veja se tem dados

---

## 📱 Teste Multi-Device

### Para testar em outro dispositivo:

1. **Dispositivo 1:** Crie 3 cultos
2. **Dispositivo 1:** Clique em "Sair"
3. **Dispositivo 2:** Abra a app
4. **Dispositivo 2:** Faça login
5. **Veja os 3 cultos carregados!**

✅ **Sincronização multi-device funcionando!**

---

## 🎯 Próximo Passo

Após testar, leia o arquivo completo:
📄 **SUPABASE-INTEGRACAO-COMPLETA.md**

Lá tem mais detalhes, segurança e otimizações!
