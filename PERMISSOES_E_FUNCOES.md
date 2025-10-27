# 🎯 FLUXOGRAMA DE PERMISSÕES E FUNÇÕES

## 1. FLUXO PRINCIPAL DA APLICAÇÃO

```
┌─────────────────────────────────────────────────────────────┐
│         REPERTÓRIO DE CULTO - MAPA DE NAVEGAÇÃO             │
└─────────────────────────────────────────────────────────────┘

                    ┌──────────────────┐
                    │  PÁGINA INICIAL  │
                    │  (Listagem)      │
                    └────────┬─────────┘
                             │
                ┌────────────┼────────────┐
                │            │            │
         ┌──────▼──────┐    │    ┌───────▼───────┐
         │ Clique Card │    │    │ Botão Float  │
         │             │    │    │ (Novo Culto) │
         └──────┬──────┘    │    └───────┬───────┘
                │           │            │
                │      [Sem ação]        │
                │                        │
         ┌──────▼────────────┐   ┌───────▼──────────┐
         │ PÁGINA DETALHES   │   │ PÁGINA FORMULÁRIO│
         │ (Ver completo)    │   │ (Criar/Editar)  │
         └──────┬─────┬──────┘   └───────┬──────────┘
                │     │                  │
        ┌───────▼─┐  │                   │
        │ Editar  │  │          ┌────────▼────────┐
        │ Deletar │  │          │ Adicionar Música│
        │ Voltar  │  │          └────────┬────────┘
        └────┬────┘  │                   │
             │       │         ┌─────────▼─────────┐
             │       │         │ Para cada música: │
             │       │         │ - Nome            │
             │       │         │ - Tom original    │
             │       │         │ - Tom desejado    │
             │       │         │ - Cifras          │
             │       │         │ - Estrutura (6)   │
             │       │         │ - Links (YT/etc)  │
             │       │         └────────┬──────────┘
             │       │                  │
        ┌────▼───────▼────────┐  ┌──────▼──────────┐
        │   PÁGINA INICIAL    │  │ Salvar ou       │
        │   (Atualiza lista)  │  │ Limpar/Voltar   │
        └────────────────────┘  └──────┬───────────┘
                ▲                       │
                │                       │
                └───────────────────────┘
```

---

## 2. MATRIZ DE PERMISSÕES E AÇÕES

### 📋 PÁGINA INICIAL - Listagem de Cultos

| Elemento | Tipo | Função | Permissão |
|----------|------|--------|-----------|
| Card Culto | Clicável | `verDetalhesCulto(id)` | Todos |
| Botão "+" | Fixo | `irParaFormulario()` | Todos |

**Ações possíveis**:
- ✅ Ver cultos
- ✅ Criar novo
- ✅ Ver detalhes

---

### 🔍 PÁGINA DETALHES - Visualizar Culto Completo

| Botão | Função | Código |
|-------|--------|--------|
| ← Voltar | Retorna inicial | `voltarParaInicial()` |
| Editar Culto | Abre formulário | `editarCulto(${culto.id})` |
| Deletar Culto ❌ | Remove com confirmação | `deletarCulto(${culto.id})` |

**Ações possíveis**:
- ✅ Visualizar todos os detalhes
- ✅ Ver músicos
- ✅ Ver músicas com estrutura
- ✅ Editar
- ✅ Deletar
- ✅ Voltar

**Dados exibidos**:
- Data formatada (DD de MMMM de YYYY)
- Nome e tema
- Ministro
- 6 Músicos com emojis
- Todas as músicas com:
  - Nome
  - Links (YouTube, Spotify, Drive)
  - Tom original → Desejado
  - Cifras transpostas
  - Estrutura transposta

---

### ✏️ PÁGINA FORMULÁRIO - Criar ou Editar

#### CULTO (Seção Superior)

| Campo | Tipo | Obrigatório | Função |
|-------|------|-------------|--------|
| nomeCulto | Texto | ❌ | Nome do culto |
| dataCulto | Data | ✅ **SIM** | Data do culto |
| temaLouvor | Texto | ❌ | Tema/Título |
| ministroLouvor | Texto | ❌ | Nome do ministro |

#### MÚSICOS (6 Campos)

| Campo | Instrumento |
|-------|------------|
| musicoBaixo | 🎸 Baixo |
| musicoGuitarra | 🎸 Guitarra |
| musicoViolao | 🎸 Violão |
| musicoTeclado | 🎹 Teclado |
| musicoBateria | 🥁 Bateria |
| musicoSopro | 🎺 Sopro |

#### MÚSICAS (Dinâmicas)

Para **CADA música** (pode ter várias):

| Campo | Tipo | Obrigatório | Ação |
|-------|------|-------------|------|
| .musica-nome | Texto | ✅ **SIM** | Nome da música |
| .musica-youtube | URL | ❌ | Link YouTube |
| .musica-spotify | URL | ❌ | Link Spotify |
| .musica-drive | URL | ❌ | Link Google Drive |
| .musica-tom-original | Select | ✅ **SIM** | Tom original |
| .musica-tom-desejado | Select | ✅ **SIM** | Tom de transposição |
| .musica-cifras | Textarea | ✅ **SIM** | Acordes (ex: [C] [Am] [F] [G]) |
| .musica-estrutura-intro | Texto | ❌ | Intros: [C] [Am] ... |
| .musica-estrutura-verso1 | Texto | ❌ | Verso 1: [F] [G] ... |
| .musica-estrutura-refrão | Texto | ❌ | Refrão: [C] [G] ... |
| .musica-estrutura-verso2 | Texto | ❌ | Verso 2: [Am] [F] ... |
| .musica-estrutura-ponte | Texto | ❌ | Ponte: [D] [A] ... |
| .musica-estrutura-final | Texto | ❌ | Final: [G] ... |

#### BOTÕES DO FORMULÁRIO

| Botão | Função | Ação |
|-------|--------|------|
| **+ Adicionar Música** | `adicionarMusica()` | Adiciona novo bloco de música |
| **Salvar Culto** | `salvarCulto()` | Valida → Transpõe → Salva localStorage |
| **Limpar** | `limparFormulario()` | Reseta tudo |
| **← Voltar** | `voltarParaInicial()` | Volta sem salvar |

---

## 3. VALIDAÇÕES - FLUXO DE SALVAR

```
┌─────────────────────────────────────┐
│ Clica em "Salvar Culto"             │
└────────────┬────────────────────────┘
             │
    ┌────────▼────────────┐
    │ Data preenchida?    │
    └───┬────────────┬────┘
        │ Não        │ Sim
        │            │
    ❌ Alert    ┌────▼──────────────────────┐
               │ Mínimo 1 música com nome? │
               └───┬──────────────────┬────┘
                   │ Não              │ Sim
                   │                  │
               ❌ Alert        ┌───────▼─────────┐
                              │ Para cada música:│
                              │ - Tom original?  │
                              │ - Tom desejado?  │
                              │ - Cifras?        │
                              └──┬──────────┬───┘
                                 │ Não      │ Sim
                                 │          │
                          [Pula]│          │
                                │    ┌─────▼──────────┐
                                │    │ Transpõe       │
                                │    │ - Cifras       │
                                │    │ - Estrutura    │
                                │    └─────┬──────────┘
                                │          │
                    ┌───────────┴──────────▼────────┐
                    │ Culto novo ou atualização?    │
                    └──┬──────────────────┬─────────┘
                       │ Novo             │ Edição
                       │                  │
                  ┌────▼────────┐  ┌──────▼──────────┐
                  │ id = Now()   │  │ Atualiza        │
                  │ Adiciona     │  │ Array existente │
                  │ ao array     │  └───────┬─────────┘
                  └────┬────────┘          │
                       │                  │
                  ┌────▼────────────────────────┐
                  │ localStorage.setItem()      │
                  │ 'cultos' = JSON.stringify() │
                  └────┬─────────────────────────┘
                       │
                  ✅ Alert Sucesso
                       │
                  ┌────▼─────────────────┐
                  │ voltarParaInicial()  │
                  │ exibirListagemCultos│
                  └─────────────────────┘
```

---

## 4. FLUXO DE DELETAR

```
┌──────────────────────────────────────────┐
│ Clica em "Deletar Culto"                 │
│ onclick="deletarCulto(${culto.id})"      │
└────────────┬─────────────────────────────┘
             │
    ┌────────▼──────────────────────────┐
    │ confirm()                          │
    │ "Tem certeza que deseja deletar   │
    │ este culto?"                       │
    └───┬──────────────────┬────────────┘
        │ Não (Cancel)     │ Sim (OK)
        │                  │
    ❌ Nada      ┌────────▼────────────────────┐
                │ cultos = cultos.filter()    │
                │ Remove culto com id = X     │
                └────────┬────────────────────┘
                         │
                  ┌──────▼──────────────────────┐
                  │ localStorage.setItem()      │
                  │ Salva array atualizado      │
                  └────────┬───────────────────┘
                           │
                  ┌────────▼──────────────────┐
                  │ voltarParaInicial()       │
                  │ exibirListagemCultos()    │
                  └───────────────────────────┘
                           │
                        ✅ Lista atualiza
                           sem o culto
```

---

## 5. FLUXO DE TRANSPOSIÇÃO

```
┌──────────────────────────────────────────┐
│ Escolhe tom original vs tom desejado     │
│ e clica "Transpor Cifras"                │
└──────────────┬───────────────────────────┘
               │
       ┌───────▼──────────────────┐
       │ transpor(musicaIndex)    │
       └───────┬──────────────────┘
               │
       ┌───────▼──────────────────────────────┐
       │ Calcula diferença em semitons:       │
       │ notas = [C, C#, D, D#, E, F, F#,...] │
       │ semitons = indice_desejado -         │
       │            indice_original           │
       └───────┬──────────────────────────────┘
               │
       ┌───────▼────────────────────┐
       │ transporCifra()            │
       │ - Cifras originais         │
       │ - Estrutura original       │
       └───┬──────────────────┬─────┘
           │ Cifras           │ Estrutura
           │                  │
       ┌───▼──────────────┐   │
       │ Regex encontra   │   │
       │ todos os acordes │   │
       │ [A-G][#b]?       │   │
       └───┬──────────────┘   │
           │                  │
       ┌───▼──────────────────┐
       │ Para cada acorde:    │
       │ novo = notas         │
       │ [(index + semitons)  │
       │  % 12]               │
       └───┬──────────────────┘
           │
       ✅ Retorna cifras transpostas

   Exemplo:
   Original: [C] [Am] [F] [G]
   Tom original: C → Tom desejado: D
   Semitons: +2
   Resultado: [D] [Bm] [G] [A]
```

---

## 6. ESTRUTURA DE DADOS NO LOCALSTORAGE

```json
{
  "cultos": [
    {
      "id": 1729970400000,
      "data": "2025-10-27",
      "nome": "Culto Especial",
      "tema": "Louvor e Adoração",
      "ministro": "Pr. João",
      "musicos": {
        "baixo": "Carlos",
        "guitarra": "Maria",
        "violao": "Pedro",
        "teclado": "Ana",
        "bateria": "João",
        "sopro": "Marcos"
      },
      "musicas": [
        {
          "nome": "Graça Maior",
          "youtube": "https://youtube.com/...",
          "spotify": "https://spotify.com/...",
          "drive": "https://drive.google.com/...",
          "tomOriginal": "C",
          "tomDesejado": "D",
          "estrutura": "INTRO: [C] [Am]\nVERSO 1: [F] [G]\nREFRÃO: [C] [G]",
          "estruturaTransposta": "INTRO: [D] [Bm]\nVERSO 1: [G] [A]\nREFRÃO: [D] [A]",
          "cifrasOriginais": "[C] [Am] [F] [G]",
          "cifrasTranspostas": "[D] [Bm] [G] [A]"
        }
      ]
    }
  ]
}
```

---

## 7. PERMISSÕES E ACESSO

### Sem Restrições ✅
- Todos podem criar cultos
- Todos podem editar cultos
- Todos podem deletar cultos
- Todos podem ver listagem
- Todos podem ver detalhes
- Todos podem transposicionar

### Restrição Única ✅
- **Salvamento requer data**: Campo obrigatório
- **Salvamento requer mínimo 1 música**: Validação
- **Editação de estrutura em 6 campos**: Obrigatória separação

### Sem Autenticação ⚠️
- Nenhuma autenticação implementada
- Todos os dados em localStorage do navegador
- Dados locais (não sincronizam entre abas)
- Para produção: considerar autenticação + backend

---

## 8. CHECKLIST DE FUNCIONALIDADES

### ✅ CRUD Completo
- [x] **C**reate: Novo culto com múltiplas músicas
- [x] **R**ead: Listar, ver detalhes
- [x] **U**pdate: Editar culto existente
- [x] **D**elete: Deletar com confirmação

### ✅ Validações
- [x] Data obrigatória
- [x] Mínimo 1 música
- [x] Nome música obrigatório para salvar
- [x] Confirmação antes de deletar

### ✅ Persistência
- [x] localStorage
- [x] JSON serialização
- [x] Carregamento na inicialização

### ✅ Transposição
- [x] 12 notas cromáticas
- [x] Cifras transpostas
- [x] Estrutura transposta

### ✅ UI/UX
- [x] Dark theme
- [x] Botão flutuante
- [x] Cards com hover
- [x] Formulário intuitivo
- [x] 6 campos de estrutura separados

### ✅ Navegação
- [x] Suave entre páginas
- [x] Volta sem salvar
- [x] Limpeza de formulário

---

## 📊 RESUMO

| Métrica | Valor |
|---------|-------|
| Páginas | 3 (Inicial, Formulário, Detalhes) |
| Botões | 11 |
| Funções principais | 15+ |
| Campos de entrada | 19 |
| Validações | 3 críticas |
| Armazenamento | localStorage (sem limite) |
| Usuários | Ilimitado (local) |
| Status | ✅ Completo e funcional |

