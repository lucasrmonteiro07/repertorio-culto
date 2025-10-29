# 🧪 Guia de Testes - Sistema de Autenticação

## ✅ TESTES RECOMENDADOS

### Teste 1: Cadastro e Login Básico

**Objetivo:** Verificar se é possível criar uma conta e fazer login

**Passos:**
1. Abra a app em http://localhost:portalocal
2. Você deve ver a tela de **LOGIN** (gradiente roxo)
3. Clique em **✏️ Criar Conta**
4. Preencha:
   - Nome: João Silva
   - Email: joao@exemplo.com
   - Senha: senha123
   - Data Nasc.: 15/05/1990
   - Cidade: São Paulo
   - Estado: SP
   - Instrumentos: Selecione "Guitarra" e "Violão"
5. Clique em **✅ Criar Conta**

**Resultado Esperado:**
- ✅ Você é logado automaticamente
- ✅ Vê o header "👤 João Silva" no canto superior esquerdo
- ✅ Vê a tela inicial com lista de cultos
- ✅ Botões flutuantes (? e +) aparecem

---

### Teste 2: Logout e Login Novamente

**Objetivo:** Verificar se o logout funciona e se é possível fazer login novamente

**Passos:**
1. Clique no botão **Sair** no header
2. Confirme "Deseja realmente sair?"
3. Você deve voltar para a tela de **LOGIN**
4. Clique em **🔓 Fazer Login**
5. Preencha:
   - Email: joao@exemplo.com
   - Senha: senha123
6. Clique em **🔓 Entrar**

**Resultado Esperado:**
- ✅ Logout funciona
- ✅ Login com dados corretos funciona
- ✅ Você volta à tela inicial

---

### Teste 3: Validação de Erros

**Objetivo:** Verificar se validações funcionam

**Teste 3a - Email incorreto:**
1. Tente fazer login com email errado ou senha errada
2. Deve aparecer mensagem: "❌ Email ou senha incorretos!"

**Teste 3b - Email já existe:**
1. Na tela de cadastro, use o email: joao@exemplo.com
2. Deve aparecer: "❌ Este email já está cadastrado!"

**Teste 3c - Senha curta:**
1. Tente fazer cadastro com senha menor que 6 caracteres
2. Deve aparecer: "❌ Senha deve ter no mínimo 6 caracteres!"

**Resultado Esperado:**
- ✅ Todas as validações funcionam
- ✅ Mensagens de erro aparecem em vermelho

---

### Teste 4: Persistência de Dados

**Objetivo:** Verificar se dados ficam salvos após recarregar página

**Passos:**
1. Faça login com joao@exemplo.com / senha123
2. Recarregue a página (F5 ou CTRL+R)
3. Você deve estar **automaticamente logado**
4. Seu nome deve aparecer no header

**Resultado Esperado:**
- ✅ Dados persistem após reload
- ✅ Não precisa fazer login novamente

---

### Teste 5: Múltiplos Usuários

**Objetivo:** Verificar se é possível ter múltiplos usuários

**Passos:**
1. Faça logout (clique "Sair")
2. Crie uma nova conta:
   - Nome: Maria Silva
   - Email: maria@exemplo.com
   - Senha: abc123456
   - Instrumentos: "Teclado"
3. Clique em **✅ Criar Conta**
4. Você deve estar logado como "Maria Silva"
5. Faça logout
6. Faça login com joao@exemplo.com
7. Você deve estar logado como "João Silva"

**Resultado Esperado:**
- ✅ Sistema suporta múltiplos usuários
- ✅ Cada usuário tem seus dados
- ✅ Alternância entre usuários funciona

---

### Teste 6: Cultos Pessoais

**Objetivo:** Verificar se cultos são salvos por usuário

**Passos:**
1. Estando logado como "João Silva"
2. Clique no botão + para criar um culto
3. Preencha:
   - Nome: Culto João 1
   - Data: 2024-10-29
   - Tema: Adoração
   - Ministro: João
4. Adicione uma música "Cantai ao Senhor"
5. Clique **Salvar Culto**
6. Você deve ver o culto listado
7. **Faça logout** e faça login como "Maria Silva"
8. Você **NÃO deve ver** o culto de João

**Resultado Esperado:**
- ✅ Cada usuário tem seus próprios cultos
- ✅ Cultos não são compartilhados por padrão

---

## 📱 TESTE EM MOBILE

1. Abra a app em um smartphone/tablet
2. Acesse: http://seu-ip-local:porta
3. Teste:
   - ✅ Tela de login responsiva
   - ✅ Formulário de cadastro com scroll
   - ✅ Botões clicáveis
   - ✅ Login funciona normalmente

---

## 🔍 VERIFICAÇÃO EM DEVTOOLS

1. Abra **F12** (DevTools)
2. Vá para **Application** → **Local Storage**
3. Você deve ver:
   - `usuarios` - Lista de todos os cadastrados
   - `usuarioLogado` - Dados do usuário logado
   - `cultos` - Lista de cultos
4. Faça logout e verá que `usuarioLogado` é deletado

---

## 🚀 PRÓXIMAS MELHORIAS

- [ ] Adicionar página de perfil do usuário
- [ ] Poder editar perfil (nome, email, instrumentos)
- [ ] Adicionar "Lembrar-me" (remember me) no login
- [ ] Recuperação de senha via email
- [ ] Integrar com Supabase Auth
- [ ] Compartilhar cultos entre usuários
- [ ] Diferentes níveis de acesso (Admin, Editor, Visualizador)

---

## 📝 CHECKLIST FINAL

- [ ] Cadastro funciona
- [ ] Login funciona
- [ ] Logout funciona
- [ ] Dados persistem após reload
- [ ] Validações aparecem
- [ ] Múltiplos usuários funcionam
- [ ] Cultos são pessoais por usuário
- [ ] Tela de login responsiva em mobile
- [ ] Sem erros no console (F12)
- [ ] Header com nome do usuário aparece

Se todos os testes passarem, ✅ **PRONTO PARA USAR!**
