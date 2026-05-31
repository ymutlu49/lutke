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
})();
