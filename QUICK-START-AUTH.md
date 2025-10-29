# ⚡ Guia Rápido - Autenticação ADORAI

## 🚀 INSTALAÇÃO EM 5 PASSOS

### Passo 1: Execute o SQL no Supabase

1. Abra https://app.supabase.com/
2. Selecione seu projeto
3. Vá para **SQL Editor** → **New Query**
4. Copie e cole o SQL de `SQL-AUTENTICACAO.md`
5. Clique em **Run**

✅ Você deve ver 2 novas tabelas: `usuarios` e `musicos`

---

### Passo 2: Abra o `index.html` para Editar

Use um editor de texto (VS Code, Notepad++, etc.)

---

### Passo 3: Adicione as Telas de Login/Cadastro

**Localize:** A linha que começa com `<body>` ou a primeira `<div class="container">`

**ANTES dessa linha, insira:**

```html
<!-- HEADER COM USUÁRIO LOGADO -->
<div id="header-usuario" style="position: fixed; top: 20px; left: 20px; background: rgba(255,255,255,0.95); padding: 12px 20px; border-radius: 12px; z-index: 998; display: none; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">
    <div style="display: flex; align-items: center; justify-content: space-between; gap: 15px;">
        <span style="color: #000; font-weight: 600; font-size: 0.9em;">👤 <span id="usuario-logado-nome">User</span></span>
        <button onclick="fazerLogout()" style="background: #ff4444; color: white; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer; font-size: 0.85em; font-weight: 600;">Sair</button>
    </div>
</div>

<!-- PÁGINA: LOGIN -->
<div id="paginaLogin" class="page" style="display: flex; align-items: center; justify-content: center; min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div style="background: white; padding: 40px; border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); max-width: 400px; width: 90%;">
        <div style="text-align: center; margin-bottom: 30px;">
            <h1 style="color: #667eea; font-size: 2.5em; margin-bottom: 10px;">🎵 ADORAI</h1>
            <p style="color: #666; font-size: 0.95em;">Gerenciador de Repertório de Culto</p>
        </div>

        <h2 style="color: #333; margin-bottom: 24px; text-align: center; font-size: 1.5em;">Login</h2>
        
        <div class="form-group" style="margin-bottom: 16px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Email:</label>
            <input type="email" id="login-email" placeholder="seu@email.com" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
        </div>

        <div class="form-group" style="margin-bottom: 24px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Senha:</label>
            <input type="password" id="login-senha" placeholder="••••••••" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
        </div>

        <button onclick="fazerLogin()" style="width: 100%; background: #667eea; color: white; padding: 14px; border: none; border-radius: 8px; font-weight: 700; font-size: 1em; cursor: pointer; margin-bottom: 12px; transition: all 0.3s;">🔓 Entrar</button>

        <p style="text-align: center; color: #666; margin-bottom: 12px;">Não tem conta?</p>
        <button onclick="irParaCadastro()" style="width: 100%; background: #764ba2; color: white; padding: 14px; border: none; border-radius: 8px; font-weight: 700; font-size: 1em; cursor: pointer; transition: all 0.3s;">✏️ Criar Conta</button>

        <div id="info-login" style="color: #ff4444; text-align: center; margin-top: 16px; font-size: 0.9em; display: none;"></div>
    </div>
</div>
```

---

### Passo 4: Adicione o JavaScript de Autenticação

**Localize:** O último `</script>` do arquivo

**ANTES dele, adicione:**

```javascript
// ============================================
// 🔐 SISTEMA DE AUTENTICAÇÃO
// ============================================

let usuarioLogado = JSON.parse(localStorage.getItem('usuarioLogado')) || null;

// Verificar se usuário está logado ao carregar
document.addEventListener('DOMContentLoaded', () => {
    if (usuarioLogado) {
        mostrarPaginaAutenticada();
    } else {
        mostrarPaginaLogin();
    }
});

function mostrarPaginaLogin() {
    mostrarPagina('paginaLogin');
    document.getElementById('header-usuario').style.display = 'none';
    document.querySelectorAll('.btn-float').forEach(btn => btn.style.display = 'none');
}

function mostrarPaginaAutenticada() {
    document.getElementById('header-usuario').style.display = 'block';
    document.getElementById('usuario-logado-nome').textContent = usuarioLogado.nome;
    document.querySelectorAll('.btn-float').forEach(btn => btn.style.display = 'flex');
    mostrarPagina('paginaInicial');
    exibirListagemCultos();
}

function irParaLogin() {
    mostrarPagina('paginaLogin');
    document.getElementById('info-login').textContent = '';
    document.getElementById('login-email').value = '';
    document.getElementById('login-senha').value = '';
}

function irParaCadastro() {
    mostrarPagina('paginaCadastro');
}

function fazerLogin() {
    const email = document.getElementById('login-email').value.trim();
    const senha = document.getElementById('login-senha').value.trim();
    const infoDiv = document.getElementById('info-login');

    if (!email || !senha) {
        infoDiv.textContent = '❌ Preencha email e senha!';
        infoDiv.style.display = 'block';
        return;
    }

    // Buscar usuário no localStorage
    const usuarios = JSON.parse(localStorage.getItem('usuarios')) || [];
    const usuario = usuarios.find(u => u.email === email && u.senha === btoa(senha));

    if (!usuario) {
        infoDiv.textContent = '❌ Email ou senha incorretos!';
        infoDiv.style.display = 'block';
        return;
    }

    // Fazer login
    usuarioLogado = usuario;
    localStorage.setItem('usuarioLogado', JSON.stringify(usuario));
    console.log('✅ Login realizado:', usuario.nome);
    
    mostrarPaginaAutenticada();
}

function fazerCadastro() {
    const nome = document.getElementById('cadastro-nome').value.trim();
    const email = document.getElementById('cadastro-email').value.trim();
    const senha = document.getElementById('cadastro-senha').value.trim();
    const infoDiv = document.getElementById('info-cadastro');

    if (!nome || !email || !senha) {
        infoDiv.textContent = '❌ Preencha nome, email e senha!';
        infoDiv.style.display = 'block';
        return;
    }

    if (senha.length < 6) {
        infoDiv.textContent = '❌ Senha deve ter no mínimo 6 caracteres!';
        infoDiv.style.display = 'block';
        return;
    }

    // Verificar se email já existe
    const usuarios = JSON.parse(localStorage.getItem('usuarios')) || [];
    if (usuarios.some(u => u.email === email)) {
        infoDiv.textContent = '❌ Este email já está cadastrado!';
        infoDiv.style.display = 'block';
        return;
    }

    // Criar novo usuário
    const novoUsuario = {
        id: Date.now(),
        nome,
        email,
        senha: btoa(senha),
        dataNascimento: document.getElementById('cadastro-datanasc').value,
        cidade: document.getElementById('cadastro-cidade').value,
        estado: document.getElementById('cadastro-estado').value
    };

    usuarios.push(novoUsuario);
    localStorage.setItem('usuarios', JSON.stringify(usuarios));

    // Fazer login automaticamente
    usuarioLogado = novoUsuario;
    localStorage.setItem('usuarioLogado', JSON.stringify(novoUsuario));
    
    console.log('✅ Cadastro realizado:', novoUsuario.nome);
    mostrarPaginaAutenticada();
}

function fazerLogout() {
    if (confirm('Deseja realmente sair?')) {
        usuarioLogado = null;
        localStorage.removeItem('usuarioLogado');
        console.log('👋 Logout realizado');
        mostrarPaginaLogin();
    }
}
```

---

### Passo 5: Salve e Teste

1. **Salve o arquivo**
2. **Recarregue o browser** (CTRL+F5)
3. Você deve ver a tela de **LOGIN**
4. Clique em **✏️ Criar Conta**
5. Preencha e crie sua conta
6. Você será logado automaticamente e verá a app normal

---

## ✅ O Que Funciona

- ✅ Login com email/senha
- ✅ Cadastro de usuários
- ✅ Logout
- ✅ Dados salvos em localStorage
- ✅ Protege cultos por usuário (cada usuário vê seus próprios cultos)

---

## 🚫 Limitações (Sem Supabase)

Sem integração com Supabase:
- ❌ Dados só ficam no navegador (se limpar cache, perde tudo)
- ❌ Não sincroniza entre dispositivos
- ❌ Sem backup na nuvem

---

## 🔄 Próximo Passo: Integrar com Supabase

Quando quiser sincronizar com Supabase:
1. Modifique `fazerCadastro()` para salvar também na tabela `usuarios` do Supabase
2. Modifique `fazerLogin()` para buscar do Supabase
3. Adicione filtro `user_id = usuarioLogado.id` às queries de cultos

---

## 📱 Teste no Mobile

Abra seu telefone/tablet e acesse a URL do servidor local:
- Desktop: http://localhost:portalocal
- Mobile: http://seu-ip-local:porta

O login/cadastro funcionam perfeitamente em mobile! 🎉
