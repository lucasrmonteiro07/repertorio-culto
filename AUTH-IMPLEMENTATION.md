# 🔐 Implementação de Autenticação - ADORAI APP

## 📋 Resumo das Alterações

Este documento descreve as mudanças necessárias para adicionar autenticação ao app.

---

## 1️⃣ MUDANÇAS NO HTML

### Adicionar LOGO e Botão de Logout no Header

Após a linha com `<div id="sync-indicator">`, adicione:

```html
<!-- HEADER COM USUÁRIO LOGADO -->
<div id="header-usuario" style="position: fixed; top: 20px; left: 20px; background: rgba(255,255,255,0.95); padding: 12px 20px; border-radius: 12px; z-index: 998; display: none; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">
    <div style="display: flex; align-items: center; justify-content: space-between; gap: 15px;">
        <span style="color: #000; font-weight: 600; font-size: 0.9em;">👤 <span id="usuario-logado-nome">User</span></span>
        <button onclick="fazerLogout()" style="background: #ff4444; color: white; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer; font-size: 0.85em; font-weight: 600;">Sair</button>
    </div>
</div>
```

---

## 2️⃣ ADICIONAR TELA DE LOGIN (Nova página)

Antes de `<div id="paginaInicial" class="page active">`, adicione:

```html
<!-- PÁGINA: LOGIN -->
<div id="paginaLogin" class="page" style="display: flex; align-items: center; justify-content: center; min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div style="background: white; padding: 40px; border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); max-width: 400px; width: 90%;">
        <div style="text-align: center; margin-bottom: 30px;">
            <h1 style="color: #667eea; font-size: 2.5em; margin-bottom: 10px;">🎵 ADORAI</h1>
            <p style="color: #666; font-size: 0.95em;">Gerenciador de Repertório de Culto</p>
        </div>

        <div id="form-login" style="display: block;">
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
        </div>

        <div id="info-login" style="color: #ff4444; text-align: center; margin-top: 16px; font-size: 0.9em; display: none;"></div>
    </div>
</div>

<!-- PÁGINA: CADASTRO -->
<div id="paginaCadastro" class="page" style="display: flex; align-items: center; justify-content: center; min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div style="background: white; padding: 40px; border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); max-width: 500px; width: 90%; max-height: 90vh; overflow-y: auto;">
        <div style="text-align: center; margin-bottom: 30px;">
            <h1 style="color: #667eea; font-size: 2.5em; margin-bottom: 10px;">🎵 ADORAI</h1>
            <p style="color: #666; font-size: 0.95em;">Crie sua conta</p>
        </div>

        <h2 style="color: #333; margin-bottom: 24px; text-align: center; font-size: 1.5em;">Cadastro</h2>
        
        <div class="form-group" style="margin-bottom: 16px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Nome Completo:</label>
            <input type="text" id="cadastro-nome" placeholder="Seu Nome" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
        </div>

        <div class="form-group" style="margin-bottom: 16px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Email:</label>
            <input type="email" id="cadastro-email" placeholder="seu@email.com" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
        </div>

        <div class="form-group" style="margin-bottom: 16px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Senha (mínimo 6 caracteres):</label>
            <input type="password" id="cadastro-senha" placeholder="••••••••" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
        </div>

        <div class="form-group" style="margin-bottom: 16px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Data de Nascimento:</label>
            <input type="date" id="cadastro-datanasc" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
        </div>

        <div class="form-group" style="margin-bottom: 16px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Cidade:</label>
            <input type="text" id="cadastro-cidade" placeholder="Ex: São Paulo" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
        </div>

        <div class="form-group" style="margin-bottom: 16px;">
            <label style="display: block; color: #333; font-weight: 600; margin-bottom: 8px;">Estado:</label>
            <select id="cadastro-estado" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; box-sizing: border-box;">
                <option value="">-- Selecione --</option>
                <option value="AC">AC - Acre</option>
                <option value="AL">AL - Alagoas</option>
                <option value="AP">AP - Amapá</option>
                <option value="AM">AM - Amazonas</option>
                <option value="BA">BA - Bahia</option>
                <option value="CE">CE - Ceará</option>
                <option value="DF">DF - Distrito Federal</option>
                <option value="ES">ES - Espírito Santo</option>
                <option value="GO">GO - Goiás</option>
                <option value="MA">MA - Maranhão</option>
                <option value="MT">MT - Mato Grosso</option>
                <option value="MS">MS - Mato Grosso do Sul</option>
                <option value="MG">MG - Minas Gerais</option>
                <option value="PA">PA - Pará</option>
                <option value="PB">PB - Paraíba</option>
                <option value="PR">PR - Paraná</option>
                <option value="PE">PE - Pernambuco</option>
                <option value="PI">PI - Piauí</option>
                <option value="RJ">RJ - Rio de Janeiro</option>
                <option value="RN">RN - Rio Grande do Norte</option>
                <option value="RS">RS - Rio Grande do Sul</option>
                <option value="RO">RO - Rondônia</option>
                <option value="RR">RR - Roraima</option>
                <option value="SC">SC - Santa Catarina</option>
                <option value="SP">SP - São Paulo</option>
                <option value="SE">SE - Sergipe</option>
                <option value="TO">TO - Tocantins</option>
            </select>
        </div>

        <div style="margin-bottom: 24px;">
            <p style="color: #333; font-weight: 600; margin-bottom: 12px;">Instrumento(s) Principal(is):</p>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Baixo"> Baixo
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Guitarra"> Guitarra
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Violão"> Violão
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Teclado"> Teclado
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Bateria"> Bateria
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Sopro"> Sopro
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Back Vocal"> Back Vocal
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #333;">
                    <input type="checkbox" name="instrumento" value="Ministro"> Ministro
                </label>
            </div>
        </div>

        <button onclick="fazerCadastro()" style="width: 100%; background: #667eea; color: white; padding: 14px; border: none; border-radius: 8px; font-weight: 700; font-size: 1em; cursor: pointer; margin-bottom: 12px; transition: all 0.3s;">✅ Criar Conta</button>

        <p style="text-align: center; color: #666;">Já tem conta?</p>
        <button onclick="irParaLogin()" style="width: 100%; background: #764ba2; color: white; padding: 14px; border: none; border-radius: 8px; font-weight: 700; font-size: 1em; cursor: pointer; transition: all 0.3s;">🔓 Fazer Login</button>

        <div id="info-cadastro" style="color: #ff4444; text-align: center; margin-top: 16px; font-size: 0.9em; display: none;"></div>
    </div>
</div>

<!-- PÁGINA: GERENCIAR MEUS MÚSICOS -->
<div id="paginaMusicosUser" class="page">
    <button class="btn-voltar" onclick="voltarParaInicial()">← Voltar</button>
    
    <h1>🎸 Meus Músicos</h1>

    <div style="margin-bottom: 30px; background: #111111; padding: 24px; border-radius: 16px; border: 1px solid #222222;">
        <h2 style="color: #ffffff; margin-bottom: 20px; font-weight: 300; font-size: 1.3em;">Adicionar Novo Músico</h2>
        
        <div class="grid-2" style="margin-bottom: 16px;">
            <div class="form-group">
                <label>Nome do Músico:</label>
                <input type="text" id="musico-nome" placeholder="Ex: Pedro Santos" style="width: 100%; padding: 10px; border: 1px solid #333; border-radius: 8px; background: #0a0a0a; color: #fff;">
            </div>
            <div style=""></div>
        </div>

        <div style="margin-bottom: 20px;">
            <p style="color: #ffffff; font-weight: 600; margin-bottom: 12px;">Instrumentos:</p>
            <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px;">
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #fff;">
                    <input type="checkbox" class="musico-instrumento" value="Baixo"> Baixo
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #fff;">
                    <input type="checkbox" class="musico-instrumento" value="Guitarra"> Guitarra
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #fff;">
                    <input type="checkbox" class="musico-instrumento" value="Violão"> Violão
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #fff;">
                    <input type="checkbox" class="musico-instrumento" value="Teclado"> Teclado
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #fff;">
                    <input type="checkbox" class="musico-instrumento" value="Bateria"> Bateria
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #fff;">
                    <input type="checkbox" class="musico-instrumento" value="Sopro"> Sopro
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: #fff;">
                    <input type="checkbox" class="musico-instrumento" value="Back Vocal"> Back Vocal
                </label>
            </div>
        </div>

        <button onclick="adicionarMusicoUser()" style="background: #667eea; color: white; padding: 12px 24px; border: none; border-radius: 8px; cursor: pointer; font-weight: 600;">+ Adicionar Músico</button>
    </div>

    <div id="lista-musicos-user" style="display: grid; gap: 16px;">
        <!-- Músicos serão listados aqui -->
    </div>
</div>
```

---

## 3️⃣ ADICIONAR FILTRO DE MÚSICOS

Na seção de filtros (onde está ministro, tema, mês), adicione:

```html
<select id="filtro-musico" class="filtro-select" onchange="executarBusca()">
    <option value="">🎸 Todos os músicos</option>
</select>

<select id="filtro-instrumento" class="filtro-select" onchange="executarBusca()">
    <option value="">🎵 Todos os instrumentos</option>
</select>
```

---

## 4️⃣ JAVASCRIPT - AUTENTICAÇÃO

Adicione no bloco `<script>` final, após `let cultos = ...`:

```javascript
// ============================================
// 🔐 SISTEMA DE AUTENTICAÇÃO
// ============================================

let usuarioLogado = JSON.parse(localStorage.getItem('usuarioLogado')) || null;
let musicos = JSON.parse(localStorage.getItem('musicos')) || [];

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
    document.getElementById('info-cadastro').textContent = '';
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
    const datanasc = document.getElementById('cadastro-datanasc').value;
    const cidade = document.getElementById('cadastro-cidade').value.trim();
    const estado = document.getElementById('cadastro-estado').value;
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

    // Validar email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        infoDiv.textContent = '❌ Email inválido!';
        infoDiv.style.display = 'block';
        return;
    }

    // Buscar instrumentos selecionados
    const instrumentos = [];
    document.querySelectorAll('input[name="instrumento"]:checked').forEach(chk => {
        instrumentos.push(chk.value);
    });

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
        dataNascimento: datanasc,
        cidade,
        estado,
        instrumentos
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

function adicionarMusicoUser() {
    const nome = document.getElementById('musico-nome').value.trim();
    const infoDiv = document.getElementById('info-cadastro') || document.getElementById('form-login');

    if (!nome) {
        alert('❌ Digite o nome do músico!');
        return;
    }

    const instrumentos = [];
    document.querySelectorAll('.musico-instrumento:checked').forEach(chk => {
        instrumentos.push(chk.value);
    });

    if (instrumentos.length === 0) {
        alert('❌ Selecione pelo menos um instrumento!');
        return;
    }

    // Criar novo músico
    const novoMusico = {
        id: Date.now(),
        usuarioId: usuarioLogado.id,
        nome,
        instrumentos,
        ativo: true
    };

    musicos.push(novoMusico);
    localStorage.setItem('musicos', JSON.stringify(musicos));

    console.log('✅ Músico adicionado:', novoMusico.nome);
    listarMusicosUser();
    document.getElementById('musico-nome').value = '';
    document.querySelectorAll('.musico-instrumento:checked').forEach(chk => chk.checked = false);
}

function listarMusicosUser() {
    const container = document.getElementById('lista-musicos-user');
    const musicosUser = musicos.filter(m => m.usuarioId === usuarioLogado.id);

    if (musicosUser.length === 0) {
        container.innerHTML = '<p style="color: #888; text-align: center;">Nenhum músico cadastrado</p>';
        return;
    }

    container.innerHTML = musicosUser.map(m => `
        <div style="background: #111111; padding: 20px; border-radius: 12px; border: 1px solid #222222;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
                <h3 style="color: #fff; margin: 0;">${m.nome}</h3>
                <button onclick="deletarMusicoUser(${m.id})" class="btn-small btn-danger">Remover</button>
            </div>
            <div style="color: #bbb; font-size: 0.9em;">
                🎵 ${m.instrumentos.join(', ')}
            </div>
        </div>
    `).join('');
}

function deletarMusicoUser(id) {
    if (confirm('Remover este músico?')) {
        musicos = musicos.filter(m => m.id !== id);
        localStorage.setItem('musicos', JSON.stringify(musicos));
        listarMusicosUser();
    }
}

// Atualizar filtro de músicos
function atualizarFiltroMusicos() {
    const selectMusico = document.getElementById('filtro-musico');
    const musicosUser = musicos.filter(m => m.usuarioId === usuarioLogado.id);
    
    musicosUser.forEach(m => {
        const option = document.createElement('option');
        option.value = m.id;
        option.textContent = m.nome;
        selectMusico.appendChild(option);
    });
}

// Modificar executarBusca() para incluir filtro de músicos
const executarBuscaOriginal = executarBusca;
function executarBusca() {
    const criterios = {
        nome: document.getElementById('busca-nome').value,
        ministro: document.getElementById('filtro-ministro').value,
        mes: document.getElementById('filtro-mes').value,
        tema: document.getElementById('filtro-tema').value,
        musico: document.getElementById('filtro-musico')?.value || '',
        instrumento: document.getElementById('filtro-instrumento')?.value || ''
    };
    
    const cultosFiltrados = filtrarCultos(cultos, criterios);
    exibirListagemCultos(cultosFiltrados);
}

// Modificar filtrarCultos para incluir músicos
const filtrarCultosOriginal = filtrarCultos;
function filtrarCultos(cultosList, criterios) {
    return cultosList.filter(culto => {
        const nomeMatch = !criterios.nome || 
            culto.nome.toLowerCase().includes(criterios.nome.toLowerCase());
        
        const ministroMatch = !criterios.ministro || 
            culto.ministro === criterios.ministro;
        
        const mesMatch = !criterios.mes || 
            culto.data.startsWith(criterios.mes);
        
        const temaMatch = !criterios.tema || 
            culto.tema === criterios.tema;

        let musicoMatch = true;
        let instrumentoMatch = true;

        if (criterios.musico) {
            const musicoSelecionado = musicos.find(m => m.id == criterios.musico);
            if (musicoSelecionado) {
                musicoMatch = Object.values(culto.musicos || {}).some(m => m === musicoSelecionado.nome);
            }
        }

        if (criterios.instrumento) {
            instrumentoMatch = Object.entries(culto.musicos || {})
                .some(([instrumento, nome]) => 
                    instrumento === criterios.instrumento.toLowerCase() && nome
                );
        }
        
        return nomeMatch && ministroMatch && mesMatch && temaMatch && musicoMatch && instrumentoMatch;
    });
}
```

---

## 📝 Passo a Passo de Implementação

1. **Execute o SQL** no Supabase (arquivo `SQL-AUTENTICACAO.md`)
2. **Copie o HTML** das telas de login/cadastro e cole no `index.html`
3. **Copie o JavaScript** de autenticação no final do arquivo
4. **Adicione os filtros** de músicos na seção de busca
5. **Teste**:
   - Faça cadastro
   - Faça login
   - Adicione músicos
   - Filtre por músico/instrumento
   - Crie culto
   - Verifique filtros

---

## 🎯 Próximos Passos

- [ ] Integrar com Supabase Auth (email/password)
- [ ] Sincronizar usuários com nuvem
- [ ] Compartilhar cultos entre usuários
- [ ] Controle de acesso por grupo (ex: só ministro pode editar)
- [ ] Histórico de alterações de cultos
