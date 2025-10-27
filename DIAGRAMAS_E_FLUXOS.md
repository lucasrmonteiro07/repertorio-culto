# 🎯 Diagrama de Estrutura e Fluxos - Repertório de Culto

## 📱 Estrutura de Páginas

```
┌─────────────────────────────────────────────────────────────┐
│                   REPERTÓRIO DE CULTO                       │
└─────────────────────────────────────────────────────────────┘
                              │
                ┌─────────────┼─────────────┐
                ▼             ▼             ▼
         ┌──────────────┐ ┌─────────────┐ ┌──────────────┐
         │  INICIAL     │ │ FORMULÁRIO  │ │  DETALHES    │
         │  (Listar)    │ │ (Criar/Edit)│ │  (Visualizar)│
         └──────────────┘ └─────────────┘ └──────────────┘
              │                 │              │
         Lista de cultos     Campos de      Informações
         + botão "+"         entrada        + ações
```

---

## 🔘 Botões e Suas Ações

### PÁGINA INICIAL
```
┌────────────────────────────────────────────────┐
│  PÁGINA INICIAL - LISTA DE CULTOS             │
├────────────────────────────────────────────────┤
│                                                │
│  [Culto 1] ──────────► Clica ──► VER DETALHES │
│  [Culto 2]                                     │
│  [Culto 3]                                     │
│                                                │
├────────────────────────────────────────────────┤
│                          [+] BOTÃO FLUTUANTE   │
│                          └──► NOVO CULTO       │
└────────────────────────────────────────────────┘
```

### PÁGINA FORMULÁRIO
```
┌──────────────────────────────────────────────┐
│  PÁGINA FORMULÁRIO                           │
├──────────────────────────────────────────────┤
│  Data: [input]              (OBRIGATÓRIO)    │
│  Nome: [input]              (Opcional)       │
│  Tema: [input]              (Opcional)       │
│  Ministro: [input]          (Opcional)       │
│                                              │
│  MÚSICOS:                                    │
│  Baixo: [input]  Guitarra: [input]           │
│  Violão: [input]  Teclado: [input]           │
│  Bateria: [input] Sopro: [input]             │
│                                              │
│  [+ ADICIONAR MÚSICA] ◄─── Dinâmico         │
│                                              │
│  MÚSICA 1:                                   │
│  Nome: [input] (OBRIGATÓRIO)                 │
│  YouTube: [input]  Spotify: [input]          │
│  Drive: [input]                              │
│  Tom Original: [select]  (OBRIGATÓRIO)       │
│  Tom Desejado: [select]  (OBRIGATÓRIO)       │
│  Cifras: [textarea]      (OBRIGATÓRIO)       │
│                                              │
│  ESTRUTURA DA MÚSICA:                        │
│  [INTRO]    [VERSO 1]  ◄─── Grid 6 campos   │
│  [REFRÃO]   [VERSO 2]                        │
│  [PONTE]    [FINAL]                          │
│                                              │
│  [REMOVER]  ◄─── Por música                  │
│                                              │
├──────────────────────────────────────────────┤
│ [SALVAR CULTO]  [LIMPAR]  [← VOLTAR]         │
└──────────────────────────────────────────────┘
```

### PÁGINA DETALHES
```
┌──────────────────────────────────────────────┐
│  PÁGINA DETALHES                             │
├──────────────────────────────────────────────┤
│                       [← VOLTAR]             │
│                                              │
│  CULTO: Nome do Culto                        │
│  Data: 27 de outubro de 2025                 │
│  Tema: Louvor e Adoração                     │
│  Ministro: Pr. João Silva                    │
│                                              │
│  MÚSICOS:                                    │
│  🎸 Baixo: Carlos                            │
│  🎸 Guitarra: Maria                          │
│  🎸 Violão: Pedro                            │
│  🎹 Teclado: Ana                             │
│  🥁 Bateria: João                            │
│  🎺 Sopro: Marcos                            │
│                                              │
│  MÚSICAS (3 músicas):                        │
│                                              │
│  1. Graça Maior                              │
│     Tom: C → D                               │
│     [YouTube] [Spotify] [Drive]              │
│     ESTRUTURA:                               │
│     INTRO: [D] [Bm] [G] [A]                  │
│     VERSO 1: [E] [B] [Gbm] [Db]              │
│     REFRÃO: [A] [E]                          │
│     ...                                      │
│                                              │
├──────────────────────────────────────────────┤
│ [EDITAR CULTO]  [🗑️ DELETAR CULTO]           │
│                                              │
│ Confirmação: "Tem certeza?"  [SIM] [NÃO]     │
└──────────────────────────────────────────────┘
```

---

## 🔄 Fluxo de Dados - Salvar Culto

```
ENTRADA:
├─ Data: "2025-10-27" ✅ OBRIGATÓRIA
├─ Nome: "Culto Domingo"
├─ Tema: "Louvor"
├─ Ministro: "Pr. João"
├─ Músicos: { baixo, guitarra, violao, teclado, bateria, sopro }
└─ Músicas: Array [
    {
      nome: "Graça Maior" ✅ OBRIGATÓRIO
      youtube: "..."
      spotify: "..."
      drive: "..."
      tomOriginal: "C" ✅ OBRIGATÓRIO
      tomDesejado: "D" ✅ OBRIGATÓRIO
      cifras: "[C] [Am] [F] [G]" ✅ OBRIGATÓRIO
      estrutura-intro: "[C] [Am]"
      estrutura-verso1: "[G] [D]"
      estrutura-refrão: "[Em] [B]"
      estrutura-verso2: "[G] [D]"
      estrutura-ponte: "[A] [E]"
      estrutura-final: "[C] [Am]"
    }
  ]

PROCESSAMENTO:
  1. Validar data ✅
  2. Para cada música:
     ├─ Validar nome ✅
     ├─ Montar estrutura com \n
     │  └─ "INTRO: [C] [Am]\nVERSO 1: [G] [D]\n..."
     ├─ Calcular semitons (D - C = 2)
     ├─ Transpor cifras
     │  └─ [C]→[D], [Am]→[Bm], [F]→[G], [G]→[A]
     └─ Transpor estrutura
  3. Validar mínimo 1 música ✅
  4. Detectar novo vs edição
     ├─ Novo: cultoId vazio → criar com id = timestamp
     └─ Edição: cultoId preenchido → atualizar existente
  5. Salvar em localStorage ✅

SAÍDA:
localStorage['cultos'] = [
  {
    id: 1730000000000,
    data: "2025-10-27",
    nome: "Culto Domingo",
    tema: "Louvor",
    ministro: "Pr. João",
    musicos: { ... },
    musicas: [
      {
        nome: "Graça Maior",
        estrutura: "INTRO: [C] [Am]\nVERSO 1: [G] [D]\n...",
        estruturaTransposta: "INTRO: [D] [Bm]\nVERSO 1: [A] [E]\n...",
        cifrasOriginais: "[C] [Am] [F] [G]",
        cifrasTranspostas: "[D] [Bm] [G] [A]"
      }
    ]
  }
]

RETORNO:
├─ Alert("Culto salvo com sucesso!")
├─ voltarParaInicial()
└─ exibirListagemCultos()
```

---

## 🔄 Fluxo de Dados - Editar Culto

```
ENTRADA:
ID: 1730000000000 (para buscar culto)

PROCESSAMENTO:
  1. Buscar culto no array
  2. Se não encontrado: retornar
  3. Ir para paginaFormulario
  4. Preencher campos básicos:
     ├─ cultoId = 1730000000000
     ├─ data, nome, tema, ministro
     └─ músicos (6 campos)
  5. Para cada música existente:
     ├─ Chamar adicionarMusica()
     ├─ Preencher campos básicos
     └─ PARSER (Split + Identifica tipo):
        │
        ├─ String: "INTRO: [C] [Am]\nVERSO 1: [G] [D]\n..."
        │
        ├─ Split por '\n':
        │  ["INTRO: [C] [Am]", "VERSO 1: [G] [D]", ...]
        │
        ├─ Para cada linha:
        │  ├─ Se começa "INTRO:" → extrair "[C] [Am]" para campo
        │  ├─ Se começa "VERSO 1:" → extrair "[G] [D]" para campo
        │  ├─ Se começa "REFRÃO:" → extrair "[...]" para campo
        │  ├─ Se começa "VERSO 2:" → extrair "[...]" para campo
        │  ├─ Se começa "PONTE:" → extrair "[...]" para campo
        │  └─ Se começa "FINAL:" → extrair "[...]" para campo

SAÍDA:
Formulário preenchido com:
├─ Dados do culto (data, nome, tema, ministro)
├─ Dados de músicos (6 instrumentos)
├─ Múltiplas músicas com:
│  ├─ Dados básicos (nome, links, tons, cifras)
│  └─ ESTRUTURA em 6 CAMPOS SEPARADOS
│     ├─ .musica-estrutura-intro = "[C] [Am]"
│     ├─ .musica-estrutura-verso1 = "[G] [D]"
│     ├─ .musica-estrutura-refrão = "[...]"
│     ├─ .musica-estrutura-verso2 = "[...]"
│     ├─ .musica-estrutura-ponte = "[...]"
│     └─ .musica-estrutura-final = "[...]"

AÇÃO ESPERADA:
Usuário edita campos e clica "Salvar Culto"
└─ Volta para salvarCulto() com cultoId preenchido
   └─ Atualiza array existente
   └─ localStorage atualizado
```

---

## 🗑️ Fluxo de Dados - Deletar Culto

```
ENTRADA:
ID: 1730000000000 (para identificar culto)

AÇÃO 1: CONFIRMAÇÃO
┌─────────────────────────────────────────────┐
│ Tem certeza que deseja deletar este culto?  │
│                                             │
│           [SIM] ────────► DELETE            │
│           [NÃO] ────────► NADA              │
└─────────────────────────────────────────────┘

SE "SIM":
  1. Remover do array:
     cultos = cultos.filter(c => c.id !== 1730000000000)
  
  2. Atualizar localStorage:
     localStorage.setItem('cultos', JSON.stringify(cultos))
  
  3. Voltar à inicial:
     voltarParaInicial()
  
  4. Atualizar listagem:
     exibirListagemCultos()

SE "NÃO":
  └─ Continuar na página de detalhes
     Nada muda

RESULTADO:
✅ localStorage atualizado
✅ UI atualizada (culto desaparece da lista)
✅ Usuário retorna à inicial
```

---

## 🎼 Fluxo de Transposição

```
ENTRADA:
  Cifras Originais: "[C] [Am] [F] [G]"
  Tom Original: C (índice 0)
  Tom Desejado: D (índice 2)
  Semitons: 2 - 0 = 2

PROCESSAMENTO:
  Notas: [C, C#, D, D#, E, F, F#, G, G#, A, A#, B]
  Índices: 0  1  2  3  4 5  6  7  8  9  10 11

  Para cada [NOTA] encontrada:
  ├─ [C]: índice 0 → (0 + 2) % 12 = 2 → [D]
  ├─ [Am]: A é 9 → (9 + 2) % 12 = 11 → [Bm]
  ├─ [F]: índice 5 → (5 + 2) % 12 = 7 → [G]
  └─ [G]: índice 7 → (7 + 2) % 12 = 9 → [A]

SAÍDA:
  Cifras Transpostas: "[D] [Bm] [G] [A]"

APLICADO TAMBÉM EM:
  ✅ Estrutura da música (cada parte)
  ✅ Armazenado junto com cifras originais
```

---

## 📊 Estrutura de Dados - Culto Completo

```
{
  "id": 1730000000000,                    ← Timestamp único
  "data": "2025-10-27",                   ← Formato YYYY-MM-DD
  "nome": "Culto de Domingo",
  "tema": "Louvor e Adoração",
  "ministro": "Pr. João Silva",
  
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
      "youtube": "https://youtube.com/watch?v=...",
      "spotify": "https://open.spotify.com/track/...",
      "drive": "https://drive.google.com/file/d/...",
      "tomOriginal": "C",
      "tomDesejado": "D",
      
      "estrutura": "INTRO: [C] [Am]\nVERSO 1: [G] [D]\nREFRÃO: [E] [B]\n...",
      "estruturaTransposta": "INTRO: [D] [Bm]\nVERSO 1: [A] [E]\nREFRÃO: [F#] [C#]\n...",
      
      "cifrasOriginais": "[C] [Am] [F] [G] ...",
      "cifrasTranspostas": "[D] [Bm] [G] [A] ..."
    },
    {
      "nome": "Aquele que Habita",
      ...
    }
  ]
}
```

---

## 🎯 Matriz de Funcionalidades

```
┌─────────────────────┬──────────┬──────────────────────────────────┐
│ Funcionalidade      │ Status   │ Detalhes                         │
├─────────────────────┼──────────┼──────────────────────────────────┤
│ Criar Culto         │ ✅       │ Validação: data + 1 música       │
│ Listar Cultos       │ ✅       │ Ordenado por data (recente)      │
│ Ver Detalhes        │ ✅       │ Formatação bonita                │
│ Editar Culto        │ ✅       │ Parser de 6 estruturas           │
│ Deletar Culto       │ ✅ NOVO  │ Com confirmação obrigatória      │
│ Adicionar Música    │ ✅       │ Dinâmico, sem limite             │
│ Remover Música      │ ✅       │ Do formulário                    │
│ Transpor Cifras     │ ✅       │ 12 notas cromáticas              │
│ Estrutura 6 Campos  │ ✅       │ INTRO, VERSO 1, REFRÃO, etc      │
│ Persistência        │ ✅       │ localStorage 100%                │
│ Dark Theme          │ ✅       │ Profissional e moderno           │
└─────────────────────┴──────────┴──────────────────────────────────┘
```

---

## 🔐 Validações

```
ANTES DE SALVAR:
┌─ Data do Culto
│  ├─ Se vazio → Alert e retorna
│  └─ Se preenchido → Continua
│
├─ Músicas
│  ├─ Se 0 músicas → Alert e retorna
│  ├─ Se música sem nome → Não salva essa
│  └─ Se 1+ músicas com nome → Continua
│
└─ Tons e Cifras (para transposição)
   ├─ Se vazio → Não transpõe (mantém original)
   └─ Se preenchido → Transpõe automaticamente

ANTES DE DELETAR:
├─ confirm('Tem certeza que deseja deletar este culto?')
├─ Se SIM → Deleta
└─ Se NÃO → Cancela
```

---

## 📁 Estrutura de Arquivos

```
repertorio-culto/
│
├─ index.html (ARQUIVO PRINCIPAL)
│  ├─ CSS (linhas 1-300)
│  │  ├─ Dark theme
│  │  ├─ Grid layouts
│  │  ├─ Button styles
│  │  └─ Responsive design
│  │
│  ├─ HTML (linhas 300-650)
│  │  ├─ paginaInicial (listagem)
│  │  ├─ paginaFormulario (criar/editar)
│  │  └─ paginaDetalhes (visualizar)
│  │
│  └─ JavaScript (linhas 650-1216)
│     ├─ salvarCulto() [LINHA 1016]
│     ├─ editarCulto() [LINHA 1161]
│     ├─ deletarCulto() [LINHA 1186] ← NOVO
│     ├─ adicionarMusica() [~LINHA 800]
│     ├─ transporCifra() [~LINHA 960]
│     └─ Outras funções
│
├─ public/index.html (BACKUP)
│  └─ Idêntico ao root
│
└─ DOCUMENTAÇÃO:
   ├─ ANALISE_ESTRUTURA.md
   ├─ CODIGO_FUNCOES_PRINCIPAIS.md
   ├─ VERIFICACAO_COMPLETA.md
   └─ README.md
```

---

## 🚀 Fluxo Completo - Um Culto Inteiro

```
INÍCIO DO DIA:

1. Usuário acessa site
   └─ Carrega cultos do localStorage
   └─ Exibe listagem na página inicial

2. Clica "+" para novo culto
   └─ Va para formulário
   └─ Preenche dados (data, nome, tema, ministro)
   └─ Preenche músicos (6 campos)
   └─ Clica "+ Adicionar Música"
   └─ Preenche música 1:
      ├─ Nome: "Graça Maior" ✅
      ├─ Tom Original: C
      ├─ Tom Desejado: D
      ├─ Cifras: "[C] [Am] [F] [G]"
      ├─ Estrutura (6 campos):
      │  ├─ INTRO: "[C] [Am]"
      │  ├─ VERSO 1: "[G] [D]"
      │  └─ ... (outros campos)
      └─ + Adicionar Música
   └─ Preenche música 2, 3, ...
   └─ Clica "SALVAR CULTO"
      └─ salvarCulto() executa:
         ├─ Valida data ✅
         ├─ Monta estruturas com \n
         ├─ Transpõe cifras (C→D)
         ├─ Transpõe estruturas
         ├─ Valida mínimo 1 música ✅
         ├─ Cria novo culto com id = timestamp
         ├─ Adiciona ao array cultos
         ├─ Salva em localStorage
         ├─ Alert "Culto salvo com sucesso!"
         └─ Volta à inicial
   └─ Novo culto aparece na lista

3. Clica no culto para ver detalhes
   └─ exibirDetalhes() mostra:
      ├─ Título, data, tema, ministro
      ├─ Lista de músicos
      └─ Músicas com cifras transpostas
   └─ Botões: [EDITAR CULTO] [DELETAR CULTO]

4. Clica "EDITAR CULTO"
   └─ editarCulto() executa:
      ├─ Busca culto pelo ID
      ├─ Preenche formulário
      ├─ Parser: string → 6 campos
      └─ Pronto para editar
   └─ Modifica dados
   └─ Clica "SALVAR CULTO"
      └─ salvarCulto() detecta cultoId
      └─ Atualiza culto existente no array
      └─ localStorage atualizado
      └─ Volta à inicial

5. Clica "DELETAR CULTO"
   └─ deletarCulto() executa:
      ├─ Exibe confirmação: "Tem certeza?"
      ├─ Usuário confirma
      ├─ Remove do array
      ├─ Atualiza localStorage
      ├─ Volta à inicial
      └─ Culto desaparece da lista

FIM DO DIA:
Todos os dados salvos em localStorage ✅
Cultos persistem mesmo fechando o navegador ✅
```

---

**Gerado em:** 27 de outubro de 2025  
**Versão:** 3.0 com diagramas e fluxos completos
