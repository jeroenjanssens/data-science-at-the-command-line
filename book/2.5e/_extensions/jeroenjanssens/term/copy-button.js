(function() {
  function addCopyButtons() {
    var pres = document.querySelectorAll('pre.term-output, pre.term-screen, pre.term-source');
    pres.forEach(function(pre) {
      var wrap = document.createElement('div');
      wrap.className = 'term-container';
      pre.parentNode.insertBefore(wrap, pre);
      wrap.appendChild(pre);
      var btn = document.createElement('button');
      btn.className = 'term-copy-btn';
      btn.setAttribute('aria-label', 'Copy commands to clipboard');
      btn.setAttribute('title', 'Copy commands to clipboard');
      var clipIcon = '<svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z"/><path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5h3zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3z"/></svg>';
      var checkIcon = '<svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/></svg>';
      btn.innerHTML = clipIcon;
      btn.addEventListener('click', function() {
        var code = pre.querySelector('code');
        var source = code || pre;
        var clone = source.cloneNode(true);
        clone.querySelectorAll('.term-output').forEach(function(el) { el.remove(); });
        var text = clone.innerText.replace(/\n{2,}/g, '\n').trim();
        navigator.clipboard.writeText(text).then(function() {
          btn.innerHTML = checkIcon;
          btn.setAttribute('title', 'Copied!');
          setTimeout(function() {
            btn.innerHTML = clipIcon;
            btn.setAttribute('title', 'Copy commands to clipboard');
          }, 1500);
        });
      });
      wrap.appendChild(btn);
    });
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', addCopyButtons);
  } else {
    addCopyButtons();
  }
})();
