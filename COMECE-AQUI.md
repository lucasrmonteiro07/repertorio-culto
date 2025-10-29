# 🚀 COMO TESTAR AGORA

## 1️⃣ Recarregue o Navegador

```
CTRL + F5 (ou CMD+Shift+R no Mac)
```

Isso limpa o cache e carrega a versão mais nova.

---

## 2️⃣ Você Deve Ver

Uma tela **roxo/gradiente** com:

```
      🎵 ADORAI
Gerenciador de Repertório de Culto

─────────────────────────
  Email:    [___________]
  Senha:    [___________]

  [🔓 Entrar]
  [✏️ Criar Conta]
─────────────────────────
```

Se não vir isso, force reload: `CTRL+Shift+Delete` (limpar cache)

---

## 3️⃣ Teste Rápido (2 minutos)

### Passo 1: Criar Conta
1. Clique em **✏️ Criar Conta**
2. Preencha:
   - Nome: `Seu Nome`
   - Email: `seu@email.com`
   - Senha: `senha123`
   - Data Nasc: `qualquer data`
   - Cidade: `São Paulo`
   - Estado: `SP`
   - Instrumentos: clique em `Guitarra` (ou qualquer um)
3. Clique **✅ Criar Conta**

### Passo 2: Você Será Logado
- Deve ver no canto superior esquerdo: `👤 Seu Nome` com botão `Sair`
- A página normal da app aparece
- Botões `?` e `+` nos cantos inferiores

### Passo 3: Logout
1. Clique em `Sair` (no header superior esquerdo)
2. Confirme "Deseja realmente sair?"
3. Você volta para a tela de login

### Passo 4: Login
1. Email: `seu@email.com`
2. Senha: `senha123`
3. Clique **🔓 Entrar**
4. Você é logado novamente!

---

## 4️⃣ O Que Funciona

✅ **Cadastro:**
- Criar usuário com dados pessoais
- Validação de email
- Validação de senha (min 6 caracteres)
- Seleção de instrumentos

✅ **Login:**
- Fazer login com email/senha
- Validação de credenciais
- Mensagens de erro

✅ **Logout:**
- Sair com confirmação
- Volta para tela de login

✅ **Persistência:**
- Dados salvos em localStorage
- Recarregue a página - continua logado!
- F5 não perde a sessão

✅ **Múltiplos Usuários:**
- Crie outra conta com email diferente
- Faça logout
- Faça login com outro usuário
- Cada um tem seus dados

---

## 5️⃣ Problemas?

### "Vejo uma página em branco"
→ Recarregue: `CTRL+F5`

### "Vejo a app normal, não a tela de login"
→ Você está logado (localStorage ainda tem usuário)
→ Para testar login: abra DevTools (F12) → Console → Cole:
```javascript
localStorage.removeItem('usuarioLogado');
location.reload();
```

### "Diz 'Email ou senha incorretos' mesmo digitando certo"
→ Verifique maiúsculas/minúsculas
→ Espaços extras antes/depois
→ Email deve ser EXATAMENTE igual ao cadastrado

### "Não consigo criar conta - erro de email"
→ Use um email que NÃO seja admin@teste.com (já existe)
→ Exemplo: `seu_email@dominio.com`

---

## 6️⃣ Entender os Dados

Abra **DevTools (F12)** → **Application** → **Local Storage**

Você verá:
```javascript
// usuarios - Todos cadastrados
usuarios: [
  {
    id: 1730246400000,
    nome: "Seu Nome",
    email: "seu@email.com",
    senha: "c2VuaGExMjM=",  // base64 de "senha123"
    instrumentos: ["Guitarra"],
    // ...
  }
]

// usuarioLogado - Quem está logado agora
usuarioLogado: {
  id: 1730246400000,
  nome: "Seu Nome",
  // ... mesmos dados acima
}

// cultos - Seus cultos (vazio se não criou nenhum)
cultos: []
```

Faça logout e veja que `usuarioLogado` desaparece!

---

## 7️⃣ Próximos Passos (Para Você)

Se tudo funcionou:

1. **Testar Criação de Cultos**
   - Depois de logado, clique em `+`
   - Crie um culto normalmente
   - Deve funcionar tudo igual antes

2. **Testar com Supabase** (Futuro)
   - Executar SQL de `SQL-AUTENTICACAO.md`
   - Modificar JavaScript para usar Supabase
   - Dados ficam na nuvem!

3. **Adicionar Página de Músicos** (Futuro)
   - Cadastrar meus músicos
   - Com instrumentos
   - Filtrar cultos por músico

---

## 📋 Checklist

- [ ] Recarreguei com CTRL+F5
- [ ] Vejo tela de login roxo
- [ ] Consigo criar conta
- [ ] Consigo fazer login
- [ ] Consigo fazer logout
- [ ] Nome aparece no header
- [ ] Consigo fazer login novamente com mesmo usuário
- [ ] Dados persistem após F5
- [ ] Consigo criar 2 usuários diferentes
- [ ] Posso alternar entre usuários com logout/login

✅ **Se tudo ok → PRONTO PARA USAR!**

---

## 🎉 Parabéns!

Você agora tem um sistema de autenticação funcional!

**Próximo:** Integrar com Supabase para dados na nuvem.

---

## 📞 Dúvidas?

Leia estes arquivos:
1. `QUICK-START-AUTH.md` - Implementação rápida
2. `AUTH-IMPLEMENTATION.md` - Detalhes técnicos
3. `TESTE-AUTENTICACAO.md` - Testes mais detalhados
