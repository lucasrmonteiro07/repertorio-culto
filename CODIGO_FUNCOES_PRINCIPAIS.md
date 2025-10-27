# 🔧 Código das Funções Principais - Repertório de Culto

## 📌 Índice
1. [Salvar Culto](#salvar-culto)
2. [Editar Culto](#editar-culto)
3. [Deletar Culto](#deletar-culto)
4. [Adicionar Música](#adicionar-música)
5. [Transposição](#transposição)

---

## Salvar Culto

### Código Completo
```javascript
function salvarCulto() {
    const data = document.getElementById('dataCulto').value;
    const nome = document.getElementById('nomeCulto').value;
    const tema = document.getElementById('temaLouvor').value;
    const ministro = document.getElementById('ministroLouvor').value;
    const cultoId = document.getElementById('cultoId').value;

    // ✅ Validação 1: Data obrigatória
    if (!data) {
        alert('Por favor, selecione uma data para o culto!');
        return;
    }

    // Coletar dados dos 6 músicos
    const musicos = {
        baixo: document.getElementById('musicoBaixo').value,
        guitarra: document.getElementById('musicoGuitarra').value,
        violao: document.getElementById('musicoViolao').value,
        teclado: document.getElementById('musicoTeclado').value,
        bateria: document.getElementById('musicoBateria').value,
        sopro: document.getElementById('musicoSopro').value
    };

    // Processar todas as músicas
    const musicas = [];
    const musicasElements = document.querySelectorAll('.musica-item');

    musicasElements.forEach((musica) => {
        const nomeMusica = musica.querySelector('.musica-nome').value;
        const youtube = musica.querySelector('.musica-youtube').value;
        const spotify = musica.querySelector('.musica-spotify').value;
        const drive = musica.querySelector('.musica-drive').value;
        const tomOriginal = musica.querySelector('.musica-tom-original').value;
        const tomDesejado = musica.querySelector('.musica-tom-desejado').value;
        const cifras = musica.querySelector('.musica-cifras').value;

        // 🎵 Capturar os 6 campos de estrutura separados
        const estruturaIntro = musica.querySelector('.musica-estrutura-intro').value;
        const estruturaVerso1 = musica.querySelector('.musica-estrutura-verso1').value;
        const estruturaRefrao = musica.querySelector('.musica-estrutura-refrão').value;
        const estruturaVerso2 = musica.querySelector('.musica-estrutura-verso2').value;
        const estruturaPonte = musica.querySelector('.musica-estrutura-ponte').value;
        const estruturaFinal = musica.querySelector('.musica-estrutura-final').value;

        // 🔗 Montar a estrutura completa com quebras de linha
        const estrutura = [
            estruturaIntro ? `INTRO: ${estruturaIntro}` : '',
            estruturaVerso1 ? `VERSO 1: ${estruturaVerso1}` : '',
            estruturaRefrao ? `REFRÃO: ${estruturaRefrao}` : '',
            estruturaVerso2 ? `VERSO 2: ${estruturaVerso2}` : '',
            estruturaPonte ? `PONTE: ${estruturaPonte}` : '',
            estruturaFinal ? `FINAL: ${estruturaFinal}` : ''
        ].filter(s => s).join('\n');

        // ✅ Validação 2: Nome da música obrigatório (só salva se preenchido)
        if (nomeMusica) {
            // 🎼 Transposição de cifras e estrutura
            const indiceOriginal = notas.indexOf(tomOriginal);
            const indiceDesejado = notas.indexOf(tomDesejado);
            const semitons = indiceDesejado - indiceOriginal;
            const cifrasTranspostas = transporCifra(cifras, semitons);
            const estruturaTransposta = transporCifra(estrutura, semitons);

            musicas.push({
                nome: nomeMusica,
                youtube,
                spotify,
                drive,
                tomOriginal,
                tomDesejado,
                estrutura,                    // Original
                estruturaTransposta,          // Transposta
                cifrasOriginais: cifras,      // Original
                cifrasTranspostas             // Transposta
            });
        }
    });

    // ✅ Validação 3: Mínimo 1 música
    if (musicas.length === 0) {
        alert('Adicione pelo menos uma música!');
        return;
    }

    // 💾 Salvar ou Atualizar
    if (cultoId) {
        // EDIÇÃO: Atualizar culto existente
        const index = cultos.findIndex(c => c.id === parseInt(cultoId));
        if (index !== -1) {
            cultos[index] = {
                id: parseInt(cultoId),
                data,
                nome,
                tema,
                ministro,
                musicos,
                musicas
            };
        }
    } else {
        // NOVO: Criar novo culto
        const culto = {
            id: Date.now(),           // ID único baseado no timestamp
            data,
            nome,
            tema,
            ministro,
            musicos,
            musicas
        };
        cultos.push(culto);
    }

    // ✅ Persistência: Salvar em localStorage
    localStorage.setItem('cultos', JSON.stringify(cultos));
    
    // ✅ Feedback ao usuário
    alert('Culto salvo com sucesso!');
    voltarParaInicial();
    exibirListagemCultos();
}
```

### Fluxo de Execução
```
salvarCulto()
  ├─ Validar data (obrigatório)
  ├─ Coletar dados do culto e músicos
  ├─ Para cada música:
  │  ├─ Coletar dados (nome, links, tons, cifras)
  │  ├─ Coletar 6 campos de estrutura
  │  ├─ Montar string estruturada
  │  ├─ Validar nome (obrigatório)
  │  ├─ Calcular transposição (semitons)
  │  ├─ Transpor cifras
  │  └─ Transpor estrutura
  ├─ Validar mínimo 1 música
  ├─ Se edição: atualizar array
  ├─ Se novo: criar com ID = timestamp
  ├─ Salvar em localStorage
  ├─ Alert de sucesso
  └─ Retornar à inicial
```

---

## Editar Culto

### Código Completo
```javascript
function editarCulto(id) {
    // 🔍 Buscar culto pelo ID
    const culto = cultos.find(c => c.id === id);
    if (!culto) return;

    // 📄 Ir para página do formulário
    mostrarPagina('paginaFormulario');
    document.getElementById('tituloFormulario').textContent = 'Editar Culto';
    
    // 📋 Preencher campos simples do culto
    document.getElementById('cultoId').value = culto.id;
    document.getElementById('nomeCulto').value = culto.nome || '';
    document.getElementById('dataCulto').value = culto.data;
    document.getElementById('temaLouvor').value = culto.tema || '';
    document.getElementById('ministroLouvor').value = culto.ministro || '';
    
    // 🎸 Preencher campos dos 6 músicos
    document.getElementById('musicoBaixo').value = culto.musicos.baixo || '';
    document.getElementById('musicoGuitarra').value = culto.musicos.guitarra || '';
    document.getElementById('musicoViolao').value = culto.musicos.violao || '';
    document.getElementById('musicoTeclado').value = culto.musicos.teclado || '';
    document.getElementById('musicoBateria').value = culto.musicos.bateria || '';
    document.getElementById('musicoSopro').value = culto.musicos.sopro || '';

    // 🧹 Limpar container de músicas anterior
    document.getElementById('musicasContainer').innerHTML = '';
    musicaIndex = 0;

    // 🎵 Adicionar músicas existentes e preencher campos
    culto.musicas.forEach((musica) => {
        // Cria novo formulário de música
        adicionarMusica();
        const musicaElement = document.querySelector(`[data-musica-index="${musicaIndex - 1}"]`);
        
        // Preencher campos básicos
        musicaElement.querySelector('.musica-nome').value = musica.nome;
        musicaElement.querySelector('.musica-youtube').value = musica.youtube || '';
        musicaElement.querySelector('.musica-spotify').value = musica.spotify || '';
        musicaElement.querySelector('.musica-drive').value = musica.drive || '';
        musicaElement.querySelector('.musica-tom-original').value = musica.tomOriginal;
        musicaElement.querySelector('.musica-tom-desejado').value = musica.tomDesejado;
        musicaElement.querySelector('.musica-cifras').value = musica.cifrasOriginais;
        
        // 🔄 PARSER: Parsear a estrutura de string para 6 campos
        const estruturaLinhas = (musica.estrutura || '').split('\n');
        estruturaLinhas.forEach(linha => {
            // Cada linha tem formato: "TIPO: [cifras]"
            if (linha.startsWith('INTRO:')) {
                musicaElement.querySelector('.musica-estrutura-intro').value = 
                    linha.replace('INTRO:', '').trim();
            } else if (linha.startsWith('VERSO 1:')) {
                musicaElement.querySelector('.musica-estrutura-verso1').value = 
                    linha.replace('VERSO 1:', '').trim();
            } else if (linha.startsWith('REFRÃO:')) {
                musicaElement.querySelector('.musica-estrutura-refrão').value = 
                    linha.replace('REFRÃO:', '').trim();
            } else if (linha.startsWith('VERSO 2:')) {
                musicaElement.querySelector('.musica-estrutura-verso2').value = 
                    linha.replace('VERSO 2:', '').trim();
            } else if (linha.startsWith('PONTE:')) {
                musicaElement.querySelector('.musica-estrutura-ponte').value = 
                    linha.replace('PONTE:', '').trim();
            } else if (linha.startsWith('FINAL:')) {
                musicaElement.querySelector('.musica-estrutura-final').value = 
                    linha.replace('FINAL:', '').trim();
            }
        });
    });
}
```

### Fluxo de Execução
```
editarCulto(id)
  ├─ Buscar culto no array
  ├─ Validar se existe
  ├─ Ir para página de formulário
  ├─ Preencher:
  │  ├─ Título para "Editar Culto"
  │  ├─ cultoId (para identificar edição)
  │  ├─ Dados básicos (data, nome, tema, ministro)
  │  └─ 6 campos de músicos
  ├─ Limpar container de músicas
  ├─ Para cada música existente:
  │  ├─ Chamar adicionarMusica()
  │  ├─ Preencher campos básicos
  │  ├─ PARSER: split('\n') na string estrutura
  │  ├─ Para cada linha: identificar tipo
  │  └─ Preencher campo correspondente
  └─ Pronto para editar
```

### Exemplo de Parser
```javascript
// String armazenada:
"INTRO: [C] [Am]\nVERSO 1: [G] [D]\nREFRÃO: [E] [B]\n"

// Após split('\n'):
[
  "INTRO: [C] [Am]",
  "VERSO 1: [G] [D]",
  "REFRÃO: [E] [B]",
  ""
]

// Após parse:
.musica-estrutura-intro   = "[C] [Am]"
.musica-estrutura-verso1  = "[G] [D]"
.musica-estrutura-refrão  = "[E] [B]"
.musica-estrutura-verso2  = ""
.musica-estrutura-ponte   = ""
.musica-estrutura-final   = ""
```

---

## Deletar Culto

### Código Completo
```javascript
function deletarCulto(id) {
    // ✅ Confirmação obrigatória do usuário
    if (confirm('Tem certeza que deseja deletar este culto?')) {
        // 🗑️ Remover do array (filter mantém tudo EXCETO o culto com id)
        cultos = cultos.filter(c => c.id !== id);
        
        // 💾 Atualizar localStorage
        localStorage.setItem('cultos', JSON.stringify(cultos));
        
        // 📄 Voltar à página inicial
        voltarParaInicial();
        
        // 🔄 Atualizar listagem
        exibirListagemCultos();
    }
    // Se o usuário clica "Cancelar", nada acontece
}
```

### Fluxo de Execução
```
deletarCulto(id)
  ├─ Exibir dialog: "Tem certeza que deseja deletar este culto?"
  ├─ Se usuário confirma:
  │  ├─ Remover culto do array (filter)
  │  ├─ Salvar novo array em localStorage
  │  ├─ Voltar à página inicial
  │  └─ Atualizar listagem (sem o culto deletado)
  └─ Se usuário cancela: não faz nada
```

### Segurança
- ✅ Confirmação visual (não pode deletar acidentalmente)
- ✅ Atualização imediata do localStorage
- ✅ UI atualiza automaticamente
- ⚠️ Sem sistema de undo (deletado fica deletado)

---

## Adicionar Música

### Código Completo (Resumido)
```javascript
function adicionarMusica() {
    const container = document.getElementById('musicasContainer');
    const novaMusicaHTML = `
        <div class="musica-item" data-musica-index="${musicaIndex}">
            <div class="musica-header">
                <h3>Música ${musicaIndex + 1}</h3>
                <button type="button" class="btn-small btn-danger" 
                        onclick="removerMusica(${musicaIndex})">Remover</button>
            </div>

            <!-- Campos básicos -->
            <div class="form-group">
                <label>Nome da Música:</label>
                <input type="text" class="musica-nome" 
                       placeholder="Ex: Rompendo em Fé">
            </div>

            <div class="form-group">
                <label>Link do YouTube:</label>
                <input type="text" class="musica-youtube" 
                       placeholder="https://www.youtube.com/watch?v=...">
            </div>

            <!-- Links em grid 2 colunas -->
            <div class="grid-2">
                <div class="form-group">
                    <label>Link do Spotify:</label>
                    <input type="text" class="musica-spotify" 
                           placeholder="https://open.spotify.com/track/...">
                </div>
                <div class="form-group">
                    <label>Link do Google Drive:</label>
                    <input type="text" class="musica-drive" 
                           placeholder="https://drive.google.com/file/d/...">
                </div>
            </div>

            <!-- Tons em grid 2 colunas -->
            <div class="grid-2">
                <div class="form-group">
                    <label>Tom Original:</label>
                    <select class="musica-tom-original">
                        <option value="C">C (Dó)</option>
                        <option value="C#">C# (Dó#)</option>
                        <option value="D">D (Ré)</option>
                        <!-- ... mais opções -->
                    </select>
                </div>
                <div class="form-group">
                    <label>Tom Desejado:</label>
                    <select class="musica-tom-desejado">
                        <!-- ... mesmas opções -->
                    </select>
                </div>
            </div>

            <!-- Cifras -->
            <div class="form-group">
                <label>Cifras:</label>
                <textarea class="musica-cifras" 
                          placeholder="Ex: [C] [Am] [F] [G]">
                </textarea>
            </div>

            <!-- 🎵 ESTRUTURA - 6 CAMPOS SEPARADOS -->
            <div style="margin-top: 20px;">
                <label style="font-weight: 700; color: #667eea;">
                    Estrutura da Música
                </label>
                <div class="grid-2" style="margin-top: 12px;">
                    <div class="form-group">
                        <label style="font-size: 0.9em; opacity: 0.8;">INTRO</label>
                        <input type="text" class="musica-estrutura-intro" 
                               placeholder="[C] [Am]">
                    </div>
                    <div class="form-group">
                        <label style="font-size: 0.9em; opacity: 0.8;">VERSO 1</label>
                        <input type="text" class="musica-estrutura-verso1" 
                               placeholder="[G] [D]">
                    </div>
                    <div class="form-group">
                        <label style="font-size: 0.9em; opacity: 0.8;">REFRÃO</label>
                        <input type="text" class="musica-estrutura-refrão" 
                               placeholder="[Em] [B]">
                    </div>
                    <div class="form-group">
                        <label style="font-size: 0.9em; opacity: 0.8;">VERSO 2</label>
                        <input type="text" class="musica-estrutura-verso2" 
                               placeholder="[G] [D]">
                    </div>
                    <div class="form-group">
                        <label style="font-size: 0.9em; opacity: 0.8;">PONTE</label>
                        <input type="text" class="musica-estrutura-ponte" 
                               placeholder="[A] [E]">
                    </div>
                    <div class="form-group">
                        <label style="font-size: 0.9em; opacity: 0.8;">FINAL</label>
                        <input type="text" class="musica-estrutura-final" 
                               placeholder="[C] [Am]">
                    </div>
                </div>
            </div>
        </div>
    `;
    
    container.innerHTML += novaMusicaHTML;
    musicaIndex++;
}
```

### Características
- ✅ Dinâmico: adiciona novo formulário no container
- ✅ Indexado: cada música tem `data-musica-index` único
- ✅ Removível: botão Remover para cada música
- ✅ 6 Estruturas: campos separados para cada parte
- ✅ Grid Layout: campos organizados em 2 colunas

---

## Transposição

### Código Completo
```javascript
function transporCifra(cifra, semitons) {
    if (!cifra || semitons === 0) return cifra;

    // Trocar sustenidos por notação alternativa para parsing
    let cifraModificada = cifra
        .replace(/C#/g, 'Db')
        .replace(/D#/g, 'Eb')
        .replace(/F#/g, 'Gb')
        .replace(/G#/g, 'Ab')
        .replace(/A#/g, 'Bb');

    // Notas cromáticas (12 semitons)
    const notas = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B'];

    // Regex para encontrar acordes entre colchetes
    return cifraModificada.replace(/\[([A-G](?:b|#)?)\]/g, (match, acorde) => {
        const indiceOriginal = notas.indexOf(acorde);
        if (indiceOriginal === -1) return match;
        
        // Calcular novo índice (com wrap-around de 12)
        const indiceNovo = (indiceOriginal + semitons) % 12;
        const acordeNovo = notas[indiceNovo < 0 ? indiceNovo + 12 : indiceNovo];
        
        return `[${acordeNovo}]`;
    });
}
```

### Exemplo de Transposição
```
Entrada: "[C] [Am] [F] [G]"
Semitons: 2 (de C para D)

Processamento:
- [C] → índice 0 → (0 + 2) % 12 = 2 → [D]
- [Am] → A é índice 9 → (9 + 2) % 12 = 11 → [Bm]
- [F] → F é índice 5 → (5 + 2) % 12 = 7 → [G]
- [G] → G é índice 7 → (7 + 2) % 12 = 9 → [A]

Saída: "[D] [Bm] [G] [A]"
```

### Notas Suportadas
```javascript
12 notas cromáticas:
0: C    (Dó)
1: C#/Db (Dó#/Ré bemol)
2: D    (Ré)
3: D#/Eb (Ré#/Mi bemol)
4: E    (Mi)
5: F    (Fá)
6: F#/Gb (Fá#/Sol bemol)
7: G    (Sol)
8: G#/Ab (Sol#/Lá bemol)
9: A    (Lá)
10: A#/Bb (Lá#/Si bemol)
11: B   (Si)
```

---

## 🎯 Fluxo Completo de Uso

### 1️⃣ Criar Culto
```
Clica "+"
→ irParaFormulario()
→ salvarCulto()
  ├─ Validar data
  ├─ Processar 6 músicas
  ├─ Transpor acordes
  └─ Salvar em localStorage
→ voltarParaInicial()
→ exibirListagemCultos()
```

### 2️⃣ Editar Culto
```
Clica no culto
→ verDetalhesCulto()
→ Clica "Editar"
→ editarCulto()
  ├─ Preencher campos
  ├─ Parser de estrutura (6 campos)
  └─ Pronto para editar
→ Modifica dados
→ salvarCulto()
  ├─ Validar
  ├─ Transpor
  └─ Atualizar localStorage
```

### 3️⃣ Deletar Culto
```
Clica no culto
→ verDetalhesCulto()
→ Clica "Deletar"
→ deletarCulto()
  ├─ Confirmação do usuário
  ├─ Remove do array
  └─ Atualiza localStorage
→ voltarParaInicial()
→ exibirListagemCultos()
```

---

## ✨ Resumo

| Função | Linha | Objetivo | Validações |
|--------|-------|----------|-----------|
| `salvarCulto()` | 1016 | Salva/atualiza culto | Data obrigatória, mínimo 1 música |
| `editarCulto()` | 1161 | Carrega para edição | Parser de 6 estruturas |
| `deletarCulto()` | 1186 | Remove culto | Confirmação obrigatória |
| `adicionarMusica()` | ~800 | Cria formulário | Sem validação na adição |
| `transporCifra()` | ~960 | Transpõe acordes | Suporta 12 notas |

---

**Documento gerado:** 27 de outubro de 2025  
**Versão:** 3.0 com Deletar Culto implementado
