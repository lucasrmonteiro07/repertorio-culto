# 🔧 DEBUG: Botões Desaparecidos

## O Problema:
Os botões flutuantes "?" (Ajuda) e "+" (Novo Culto) não estão visíveis.

---

## ✅ Verificação Rápida

### 1️⃣ Abra o Console (F12)
```
Pressione: F12 no navegador
```

### 2️⃣ Veja as mensagens de debug:
```
✅ Botão Ajuda: Encontrado
✅ Botão Adicionar: Encontrado
Ajuda - Display: flex
Adicionar - Display: flex
```

Se mostrar isso, os botões **existem e estão visíveis**!

---

## 🔍 Se os botões NÃO aparecerem no Console:

### Possível Causa 1: Cache do navegador
```
1. Pressione CTRL+F5 (Ctrl+Shift+R no Mac)
2. Isso limpa o cache e recarrega a página
3. Teste novamente
```

### Possível Causa 2: CSS quebrado
```
No Console, execute:
```
```javascript
// Mostrar CSS dos botões
const btn = document.querySelector('.btn-float.btn-adicionar');
console.log(window.getComputedStyle(btn));

// Forçar visibilidade (teste)
btn.style.display = 'flex';
btn.style.visibility = 'visible';
btn.style.opacity = '1';
```

Se aparecer após isso, há problema de CSS.

### Possível Causa 3: Z-index bloqueado
```javascript
// Verificar z-index
const btn = document.querySelector('.btn-float');
console.log('Z-index:', window.getComputedStyle(btn).zIndex);
// Deve ser 1000

// Forçar para frente
btn.style.zIndex = '9999';
```

---

## ✨ Solução Permanente

Se encontrou o problema, avise:

1. **Cache?** → Ao recarregar com CTRL+F5 funcionou? Problema resolvido!
2. **CSS?** → Envie a saída do `getComputedStyle()`
3. **Z-index?** → O `zIndex` é 1000? Se não, há conflito

---

## 🚀 Se Nada Funcionar:

Execute isso no Console para **forçar os botões a aparecer**:

```javascript
// Adicionar CSS inline para botões
const style = document.createElement('style');
style.textContent = `
    .btn-float {
        position: fixed !important;
        bottom: 20px !important;
        right: 20px !important;
        width: 60px !important;
        height: 60px !important;
        border-radius: 50% !important;
        background: white !important;
        color: black !important;
        font-size: 28px !important;
        border: none !important;
        cursor: pointer !important;
        z-index: 99999 !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        box-shadow: 0 4px 20px rgba(0,0,0,0.3) !important;
    }
    
    .btn-float.btn-ajuda {
        right: 80px !important;
    }
`;
document.head.appendChild(style);
console.log('✅ CSS forçado! Botões devem aparecer agora!');
```

---

## 📱 Teste em Diferentes Tamanhos

| Tamanho | Botão Ajuda | Botão Adicionar |
|---------|-------------|-----------------|
| Desktop (1200px+) | ✅ Visível | ✅ Visível |
| Tablet (768px) | ✅ Visível | ✅ Visível |
| Mobile (480px) | ✅ Visível (esq.) | ✅ Visível (dir.) |
| Extra-small (340px) | ✅ Visível (menor) | ✅ Visível (menor) |

Se não vê em nenhum tamanho, execute o JavaScript forçado acima.

---

## 🎯 Próximo Passo:

Após confirmar que os botões aparecem:

1. **Clique em "+"** → Deve ir para formulário novo culto
2. **Clique em "?"** → Deve mostrar tabela de referência musical
3. **F12 → Console** → Veja os logs de sincronização

---

## 📞 Se Persistir:

```
1. Que mensagens aparecem no Console?
2. Qual tamanho de tela está testando?
3. Qual navegador/celular?
4. Botão aparece em branco ou preto?
```

Compartilhe isso para ajuda rápida!
