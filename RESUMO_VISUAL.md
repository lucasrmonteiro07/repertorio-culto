# 🎯 RESUMO VISUAL - REPERTÓRIO DE CULTO

## 🎵 O QUE É?

Aplicação **web** para gerenciar repertório de músicas em cultos/eventos religiosos com suporte a **transposição de acordes** automática.

---

## 📱 TELAS

### Tela 1️⃣ - Inicial (Listagem)
```
┌─────────────────────────────────┐
│   REPERTÓRIO DE CULTO           │
├─────────────────────────────────┤
│                                 │
│  ┌──────────────────────────┐  │
│  │ 📅 Domingo, 27 out 2025  │  │
│  │ 🎤 Culto Especial        │  │
│  │ 👤 Pr. João (Ministro)  │  │
│  │ 🎵 6 músicas             │  │
│  └──────────────────────────┘  │
│  [CLICÁVEL]                     │
│                                 │
│  ┌──────────────────────────┐  │
│  │ 📅 Domingo, 20 out 2025  │  │
│  │ 🎤 Louvor               │  │
│  │ 👤 Pr. Maria (Ministro)│  │
│  │ 🎵 4 músicas             │  │
│  └──────────────────────────┘  │
│  [CLICÁVEL]                     │
│                                 │
│     ┌─────┐                     │
│     │ + ➕ │  (Novo Culto)      │
│     └─────┘ (Flutuante)        │
└─────────────────────────────────┘
```

### Tela 2️⃣ - Detalhes (Visualizar)
```
┌─────────────────────────────────┐
│ ← Voltar                        │
├─────────────────────────────────┤
│                                 │
│ 📅 Domingo, 27 de outubro      │
│ 🎤 CULTO ESPECIAL              │
│ 👤 Pr. João (Ministro)         │
│                                 │
│ 🎼 TEMA: Louvor e Adoração    │
│                                 │
│ 🎸 MÚSICOS:                     │
│   🎸 Guitarra: Maria           │
│   🎹 Teclado: Ana              │
│   🥁 Bateria: João             │
│   🎺 Sopro: Marcos             │
│                                 │
│ 🎵 MÚSICAS:                     │
│   1. Graça Maior               │
│      Tom: C → D                │
│      Cifras: [D] [Bm] [G] [A]  │
│      INTRO: [D] [Bm]...        │
│                                 │
│   2. Sempre Fiel               │
│      Tom: G → A                │
│      Cifras: [A] [F#m] ...     │
│                                 │
│ [Editar Culto] [❌ Deletar]    │
│                                 │
└─────────────────────────────────┘
```

### Tela 3️⃣ - Formulário (Criar/Editar)
```
┌─────────────────────────────────┐
│ ← Voltar                        │
│                                 │
│ NOVO CULTO                      │
├─────────────────────────────────┤
│                                 │
│ 📅 Data do Culto: [__________] │
│ 🎤 Nome: [_____________]       │
│ 📝 Tema: [_____________]       │
│ 👤 Ministro: [_____________]   │
│                                 │
│ 🎸 MÚSICOS:                    │
│   Baixo: [___________]         │
│   Guitarra: [___________]      │
│   Violão: [___________]        │
│   Teclado: [___________]       │
│   Bateria: [___________]       │
│   Sopro: [___________]         │
│                                 │
│ 🎵 MÚSICAS:                    │
│ ┌──────────────────────────┐   │
│ │ MÚSICA 1                 │   │
│ │ Nome: [Graça Maior]      │   │
│ │ YouTube: [_________]     │   │
│ │ Spotify: [_________]     │   │
│ │ Drive: [_________]       │   │
│ │ Tom Original: [C ▼]      │   │
│ │ Tom Desejado: [D ▼]      │   │
│ │ Cifras: [C] [Am] [F]...  │   │
│ │                          │   │
│ │ ESTRUTURA:               │   │
│ │ INTRO: [C] [Am]          │   │
│ │ VERSO 1: [F] [G]         │   │
│ │ REFRÃO: [C] [G]          │   │
│ │ VERSO 2: [Am] [F]        │   │
│ │ PONTE: [D] [A]           │   │
│ │ FINAL: [G]               │   │
│ │                          │   │
│ │ [Transpor] [Remover]     │   │
│ └──────────────────────────┘   │
│                                 │
│ [+ Adicionar Música]           │
│                                 │
│ [Salvar Culto] [Limpar]        │
│                                 │
└─────────────────────────────────┘
```

---

## 🎮 CONTROLES (BOTÕES)

### Página Inicial
| Ação | Botão | Local |
|------|-------|-------|
| Novo Culto | **+** | Flutuante (canto inferior direito) |
| Ver Detalhes | Clique no Card | Card de culto |

### Página Detalhes
| Ação | Botão |
|------|-------|
| Voltar | ← Voltar |
| Editar | Editar Culto |
| Deletar | ❌ Deletar Culto |

### Página Formulário
| Ação | Botão |
|------|-------|
| Voltar | ← Voltar |
| Adicionar Música | + Adicionar Música |
| Transpor | Transpor Cifras (por música) |
| Remover Música | Remover (por música) |
| Salvar | Salvar Culto |
| Limpar | Limpar |

---

## 📊 DADOS SALVOS

### Estrutura de um Culto
```
{
  id: 1729970400000,
  data: "2025-10-27",
  nome: "Culto Especial",
  tema: "Louvor e Adoração",
  ministro: "Pr. João",
  musicos: {
    baixo: "Carlos",
    guitarra: "Maria",
    violao: "Pedro",
    teclado: "Ana",
    bateria: "João",
    sopro: "Marcos"
  },
  musicas: [
    {
      nome: "Graça Maior",
      youtube: "url...",
      spotify: "url...",
      drive: "url...",
      tomOriginal: "C",
      tomDesejado: "D",
      cifrasOriginais: "[C] [Am] [F] [G]",
      cifrasTranspostas: "[D] [Bm] [G] [A]",
      estrutura: "INTRO: [C] [Am]\nVERSO 1: [F] [G]...",
      estruturaTransposta: "INTRO: [D] [Bm]\nVERSO 1: [G] [A]..."
    }
  ]
}
```

---

## ⚙️ FUNCIONALIDADES

### ✅ Criar Culto
1. Clica em **+**
2. Preenche dados (data obrigatória)
3. Preenche músicos (opcional)
4. Adiciona músicas (mínimo 1)
5. Clica **Salvar Culto**
6. ✨ Volta para listagem atualizada

### ✅ Editar Culto
1. Clica no card do culto
2. Clica **Editar Culto**
3. Muda dados desejados
4. Clica **Salvar Culto**
5. ✨ Volta para inicial

### ✅ Deletar Culto
1. Clica no card do culto
2. Clica **❌ Deletar Culto**
3. Confirma no popup
4. ✨ Culto removido

### ✅ Transposição Automática
1. Seleciona Tom Original: **C**
2. Seleciona Tom Desejado: **D**
3. Clica **Transpor Cifras**
4. Todos os acordes são transpostos:
   - Original: `[C] [Am] [F] [G]`
   - Transposto: `[D] [Bm] [G] [A]`

### ✅ Estrutura Separada
Cada música tem 6 campos:
- **INTRO**: Acordes da introdução
- **VERSO 1**: Acordes do verso 1
- **REFRÃO**: Acordes do refrão
- **VERSO 2**: Acordes do verso 2
- **PONTE**: Acordes da ponte
- **FINAL**: Acordes do final

---

## 🔐 PERMISSÕES

| Ação | Permissão | Restrição |
|------|-----------|-----------|
| Criar | ✅ Todos | Data obrigatória |
| Editar | ✅ Todos | - |
| Deletar | ✅ Todos | Confirmação visual |
| Ver Detalhes | ✅ Todos | - |
| Listar | ✅ Todos | - |
| Transpor | ✅ Todos | Tom original e desejado |

**⚠️ Nota**: Sem autenticação. Todos têm acesso completo aos dados.

---

## 💾 ARMAZENAMENTO

- **Local**: localStorage do navegador
- **Formato**: JSON
- **Chave**: `'cultos'`
- **Sincronização**: Apenas no navegador (não sincroniza entre abas)
- **Limite**: ~5-10MB por domínio
- **Persistência**: Até usuário limpar dados do navegador

---

## 🎨 DESIGN

### Tema
- **Fundo**: Preto (`#000000`)
- **Texto**: Branco (`#ffffff`)
- **Botões**: Azul Vercel (`#2596be`)
- **Deletar**: Vermelho (`#dc3545`)
- **Modo**: Dark Theme

### Componentes
- Cards com hover effect
- Botão flutuante circular
- Formulário com labels uppercase
- Tooltips nos botões
- Feedback visual (alerts)

---

## 📋 VALIDAÇÕES

✅ **Data obrigatória** para salvar culto
✅ **Mínimo 1 música** para salvar culto
✅ **Nome música obrigatório** para incluir
✅ **Tom original e desejado** para transpor
✅ **Confirmação** antes de deletar

---

## 🚀 STATUS

| Funcionalidade | Status |
|---|---|
| Criar culto | ✅ Completo |
| Editar culto | ✅ Completo |
| Deletar culto | ✅ Completo |
| Ver detalhes | ✅ Completo |
| Transposição | ✅ Completo |
| Estrutura separada | ✅ Completo |
| Salvamento | ✅ localStorage |
| UI/UX | ✅ Dark theme |
| Navegação | ✅ Suave |
| Responsividade | ✅ Mobile-friendly |

---

## 📝 RESUMO

**Repertório de Culto** é um aplicativo completo e funcional para gerenciar música em eventos religiosos, com:

- ✨ **CRUD completo** (criar, ler, atualizar, deletar)
- 🎼 **Transposição automática** de 12 notas
- 🎵 **Estrutura de música em 6 partes**
- 💾 **Persistência em localStorage**
- 🎨 **UI dark theme moderna**
- 📱 **Responsivo e funcional**
- ❌ **Deletar com confirmação**
- 🎯 **Zero dependências externas** (HTML + CSS + Vanilla JS)

**Deploy**: Vercel ✅ Funcionando

---

*Última atualização: 27 de outubro de 2025*
