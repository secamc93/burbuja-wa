// Modo compacto para ZapZap: marca las columnas de WhatsApp Web con clases
// estables (zz-*) para que compacto.css las muestre de a una en ventanas angostas.
(() => {
  if (window.__zzCompacto) return;
  window.__zzCompacto = true;

  const marcar = () => {
    const side = document.getElementById('side');
    if (!side) return;
    const lista = side.parentElement;
    const grid = lista && lista.parentElement;
    if (!grid) return;
    grid.classList.add('zz-grid');
    lista.classList.add('zz-lista');
    for (const hijo of grid.children) {
      if (hijo.matches('header[data-tab]')) hijo.classList.add('zz-nav');
      else if (hijo.dataset.testid === 'drawer-right') hijo.classList.add('zz-derecha');
      else if (hijo.querySelector(':scope > #main, :scope > [data-testid="intro-panel"]')) hijo.classList.add('zz-chat');
    }
    const enChat = !!document.getElementById('main');
    document.documentElement.classList.toggle('zz-en-chat', enChat);

    const header = enChat && document.querySelector('#main > header');
    if (header && !header.querySelector('.zz-volver')) {
      const b = document.createElement('button');
      b.className = 'zz-volver';
      b.title = 'Volver a los chats';
      b.innerHTML = '<svg viewBox="0 0 24 24" width="22" height="22"><path fill="currentColor" d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/></svg>';
      b.addEventListener('mousedown', e => e.preventDefault());  // no robar el foco
      b.addEventListener('click', e => {
        e.stopPropagation();
        // WhatsApp cierra el chat con Escape, pero solo lo escucha en el cuadro de texto
        const caja = document.querySelector('#main footer [contenteditable="true"]') || document.activeElement;
        caja.dispatchEvent(new KeyboardEvent('keydown', {key: 'Escape', code: 'Escape', keyCode: 27, which: 27, bubbles: true, cancelable: true}));
      });
      header.prepend(b);
    }
  };

  let pendiente = false;
  new MutationObserver(() => {
    if (pendiente) return;
    pendiente = true;
    requestAnimationFrame(() => { pendiente = false; marcar(); });
  }).observe(document.documentElement, {childList: true, subtree: true});
  marcar();
})();
