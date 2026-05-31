/* LÛTKE — site interactions (vanilla, no deps) */
(function () {
  'use strict';

  // --- mobile nav toggle ---
  var toggle = document.getElementById('nav-toggle');
  var nav = document.getElementById('primary-nav');
  if (toggle && nav) {
    toggle.addEventListener('click', function () {
      var open = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    // close on link click (mobile)
    nav.addEventListener('click', function (e) {
      if (e.target.closest('a') && nav.classList.contains('open')) {
        nav.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
      }
    });
    // close on Escape
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && nav.classList.contains('open')) {
        nav.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
        toggle.focus();
      }
    });
  }

  // --- Naverok açılır menü (mobil: tıkla-aç; masaüstü: CSS hover) ---
  var drops = document.querySelectorAll('.has-dropdown');
  drops.forEach(function (dd) {
    var btn = dd.querySelector('.nav-drop-toggle');
    if (!btn) return;
    btn.addEventListener('click', function (e) {
      // masaüstünde de tıklamayla aç/kapat çalışsın (klavye/dokunmatik dostu)
      e.stopPropagation();
      var isOpen = dd.classList.toggle('open');
      btn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
      // diğer açık dropdown'ları kapat
      drops.forEach(function (o) {
        if (o !== dd) { o.classList.remove('open'); var b = o.querySelector('.nav-drop-toggle'); if (b) b.setAttribute('aria-expanded', 'false'); }
      });
    });
  });
  // dışarı tıkla → kapat
  document.addEventListener('click', function (e) {
    if (!e.target.closest('.has-dropdown')) {
      drops.forEach(function (o) { o.classList.remove('open'); var b = o.querySelector('.nav-drop-toggle'); if (b) b.setAttribute('aria-expanded', 'false'); });
    }
  });

  // --- header subtle shadow on scroll ---
  var header = document.getElementById('site-header');
  if (header) {
    var onScroll = function () {
      if (window.scrollY > 8) header.style.boxShadow = '0 6px 24px rgba(12,82,71,.08)';
      else header.style.boxShadow = 'none';
    };
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
  }

  // --- naverok (eski örnek vitrin): level filter ---
  var chips = document.querySelectorAll('[data-filter]');
  if (chips.length) {
    chips.forEach(function (chip) {
      chip.addEventListener('click', function () {
        var f = chip.getAttribute('data-filter');
        chips.forEach(function (c) { c.classList.toggle('active', c === chip); });
        document.querySelectorAll('[data-level]').forEach(function (el) {
          el.classList.toggle('hide', f !== 'all' && el.getAttribute('data-level') !== f);
        });
      });
    });
  }

  // --- peyv (kelime listesi): arama + kategori filtresi ---
  var wtable = document.getElementById('wtable');
  if (wtable) {
    var rows = Array.prototype.slice.call(wtable.querySelectorAll('tbody tr'));
    var searchEl = document.getElementById('wsearch');
    var countEl = document.getElementById('wcount');
    var emptyEl = document.getElementById('wempty');
    var wchips = document.querySelectorAll('[data-wfilter]');
    var activeCat = 'all';
    var query = '';

    function norm(s) {
      // aksanları sadeleştir → ê→e, î→i, û→u, ç→c, ş→s (arama toleransı)
      return (s || '').toLowerCase()
        .replace(/ê/g, 'e').replace(/î/g, 'i').replace(/û/g, 'u')
        .replace(/ç/g, 'c').replace(/ş/g, 's');
    }

    function apply() {
      var q = norm(query.trim());
      var shown = 0;
      for (var i = 0; i < rows.length; i++) {
        var r = rows[i];
        var catOk = activeCat === 'all' || r.getAttribute('data-wcat') === activeCat;
        var qOk = !q || norm(r.getAttribute('data-hay')).indexOf(q) !== -1;
        var vis = catOk && qOk;
        r.classList.toggle('hide', !vis);
        if (vis) shown++;
      }
      if (countEl) countEl.textContent = shown + ' peyv';
      if (emptyEl) emptyEl.classList.toggle('hide', shown !== 0);
    }

    if (searchEl) {
      searchEl.addEventListener('input', function () { query = searchEl.value; apply(); });
    }
    wchips.forEach(function (chip) {
      chip.addEventListener('click', function () {
        activeCat = chip.getAttribute('data-wfilter');
        wchips.forEach(function (c) { c.classList.toggle('active', c === chip); });
        apply();
      });
    });
  }

  // --- cand/gotinen-pesiyan hub: arama yazınca harf-kartları gizlenir,
  //     tüm atasözleri tablosu görünür ve filtrelenir; boşken kartlara döner ---
  var ptable = document.getElementById('ptable');
  var psearch = document.getElementById('psearch');
  if (ptable && psearch) {
    var prows = Array.prototype.slice.call(ptable.querySelectorAll('tbody tr'));
    var pcount = document.getElementById('pcount');
    var pempty = document.getElementById('pempty');
    var pletters = document.getElementById('pletters');
    var ptotalTxt = pcount ? pcount.textContent : '';

    function pnorm(s) {
      return (s || '').toLowerCase()
        .replace(/ê/g, 'e').replace(/î/g, 'i').replace(/û/g, 'u')
        .replace(/ç/g, 'c').replace(/ş/g, 's');
    }
    psearch.addEventListener('input', function () {
      var q = pnorm(psearch.value.trim());
      if (!q) { // boş arama → harf kartlarına dön
        if (pletters) pletters.classList.remove('hide');
        ptable.classList.add('hide');
        if (pempty) pempty.classList.add('hide');
        if (pcount) pcount.textContent = ptotalTxt;
        return;
      }
      if (pletters) pletters.classList.add('hide');
      ptable.classList.remove('hide');
      var shown = 0;
      for (var i = 0; i < prows.length; i++) {
        var vis = pnorm(prows[i].getAttribute('data-hay')).indexOf(q) !== -1;
        prows[i].classList.toggle('hide', !vis);
        if (vis) shown++;
      }
      if (pcount) pcount.textContent = shown.toLocaleString('tr-TR') + ' gotin';
      if (pempty) pempty.classList.toggle('hide', shown !== 0);
    });
  }

  // --- nasil-denir hub: kelime arama ---
  var ndtable = document.getElementById('ndtable');
  var ndsearch = document.getElementById('ndsearch');
  if (ndtable && ndsearch) {
    var ndrows = Array.prototype.slice.call(ndtable.querySelectorAll('tbody tr'));
    var ndcount = document.getElementById('ndcount');
    var ndempty = document.getElementById('ndempty');
    function ndnorm(s) {
      return (s || '').toLowerCase()
        .replace(/ê/g, 'e').replace(/î/g, 'i').replace(/û/g, 'u')
        .replace(/ç/g, 'c').replace(/ş/g, 's').replace(/ı/g, 'i').replace(/ğ/g, 'g').replace(/ö/g, 'o').replace(/ü/g, 'u');
    }
    ndsearch.addEventListener('input', function () {
      var q = ndnorm(ndsearch.value.trim());
      var shown = 0;
      for (var i = 0; i < ndrows.length; i++) {
        var vis = !q || ndnorm(ndrows[i].getAttribute('data-hay')).indexOf(q) !== -1;
        ndrows[i].classList.toggle('hide', !vis);
        if (vis) shown++;
      }
      if (ndcount) ndcount.textContent = shown.toLocaleString('tr-TR') + ' ifade';
      if (ndempty) ndempty.classList.toggle('hide', shown !== 0);
    });
  }
})();
