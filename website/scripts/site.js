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

  // --- naverok: level filter ---
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
})();
