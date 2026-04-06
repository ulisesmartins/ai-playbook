/* global role-filter.js — injected on every page via extra_javascript */
(function () {
  'use strict';

  var KEY = 'dp-role';

  var ROLES = [
    { value: 'pm',          short: '💼 PM',      full: '💼 Product' },
    { value: 'ui',           short: '📐 UI',      full: '📐 UI' },
    { value: 'coding',      short: '🖥️ Code',    full: '🖥️ Coding' },
    { value: 'xfn',         short: '🤝 XFN',     full: '🤝 Cross-functional' }
  ];

  /* Role-aware destinations for each section.
     Sections NOT listed here have no role routing. */
  var NAV_MAP = {
    '02_templates': {
      pm: '/02_templates/pm/',       ui: '/02_templates/ui/',
      coding: '/02_templates/cross-functional/', xfn: '/02_templates/cross-functional/'
    },
    '03_skills': {
      pm: '/03_skills/pm/',          ui: '/03_skills/ui/',
      coding: '/03_skills/coding/',          xfn: '/03_skills/cross-functional/'
    },
    '04_agents': {
      pm: '/04_agents/pm/',          ui: '/04_agents/ui/',
      coding: '/04_agents/coding/',          xfn: '/04_agents/cross-functional/'
    },
    '05_prompts': {
      pm: '/05_prompts/pm/',         ui: '/05_prompts/ui/',
      coding: '/05_prompts/coding/',         xfn: '/05_prompts/pm/'
    },
    '06_cowork-plugins': {
      pm: '/06_cowork-plugins/pm/',  ui: '/06_cowork-plugins/ui/',
      coding: '/06_cowork-plugins/coding/',  xfn: '/06_cowork-plugins/cross-functional/'
    },
    '07_examples': {
      pm: '/07_examples/pm/',        ui: '/07_examples/ui/',
      coding: '/07_examples/coding/',        xfn: '/07_examples/cross-functional/'
    },
    '08_tools': {
      pm: '/08_tools/pm/',           ui: '/08_tools/ui/',
      coding: '/08_tools/coding/',           xfn: '/08_tools/cross-functional/'
    },
    '10_hooks': {
      pm: '/10_hooks/pm/',           ui: '/10_hooks/ui/',
      coding: '/10_hooks/coding/',           xfn: '/10_hooks/cross-functional/'
    }
  };

  /* ── Detect site base path (e.g. "/ai-playbook/") ── */

  function getBase() {
    var path = window.location.pathname;
    /* Strip everything from the first numbered section directory onward
       e.g. /ai-playbook/00_getting-started/… → /ai-playbook/ */
    var idx = path.search(/(?:0[0-9]|1[0-9])_/);
    if (idx > 0) return path.substring(0, idx);
    /* Strip known root-level page slugs */
    var slugs = ['directory/', 'contributing/', 'whats-new/'];
    for (var i = 0; i < slugs.length; i++) {
      idx = path.indexOf(slugs[i]);
      if (idx > 0) return path.substring(0, idx);
    }
    /* Homepage — path is already the base */
    return path.replace(/\/?$/, '/');
  }

  /* ── Helpers ── */

  function getSaved() {
    try { return localStorage.getItem(KEY) || 'pm'; } catch (e) { return 'pm'; }
  }

  function getRole(value) {
    for (var i = 0; i < ROLES.length; i++) {
      if (ROLES[i].value === value) return ROLES[i];
    }
    return ROLES[0];
  }

  /* Extract section key from any href (relative or absolute).
     "03_skills/pm/" → "03_skills"
     "/03_skills/design/" → "03_skills"
     "../04_agents/pm/" → "04_agents" */
  function extractSection(href) {
    var m = (href || '').match(/((?:0[0-9]|1[0-9])_[a-z-]+)\//);
    return m ? m[1] : null;
  }

  /* ── Rewrite all role-based hrefs on the page ── */

  function rewriteLinks(role) {
    var links = document.querySelectorAll('a[href]');
    for (var i = 0; i < links.length; i++) {
      var a = links[i];
      var href = a.getAttribute('href');

      /* Skip external links and anchors */
      if (!href || href.charAt(0) === '#' || href.indexOf('http') === 0) continue;

      var section = extractSection(href);
      if (!section || !NAV_MAP[section]) continue;

      var dest = NAV_MAP[section][role];
      if (!dest) continue;

      /* Rewrite the href to the role-appropriate path, prepending site base */
      a.setAttribute('href', getBase() + dest.replace(/^\//, ''));
    }
  }

  /* ── Apply role (show/hide content, sync UI, rewrite links) ── */

  function applyRole(role, navigate) {
    try { localStorage.setItem(KEY, role); } catch (e) {}

    /* Show/hide role-gated blocks */
    document.querySelectorAll('[data-role]').forEach(function (el) {
      el.classList.toggle('dp-role-active', el.getAttribute('data-role') === role);
    });

    /* Sync legacy inline selects */
    document.querySelectorAll('.dp-role-select').forEach(function (sel) {
      if (sel.value !== role) sel.value = role;
    });

    /* Update header picker label */
    var label = document.querySelector('.dp-role-trigger-label');
    if (label) label.textContent = getRole(role).short;

    /* Update dropdown selected state */
    document.querySelectorAll('.dp-role-option').forEach(function (el) {
      el.setAttribute('aria-selected', el.getAttribute('data-value') === role ? 'true' : 'false');
    });

    /* Rewrite all links to match the role */
    rewriteLinks(role);

    /* If already on a role-routed page, navigate to the correct sub-section */
    if (navigate) {
      var section = extractSection(window.location.pathname);
      if (section && NAV_MAP[section]) {
        var dest = getBase() + NAV_MAP[section][role].replace(/^\//, '');
        if (dest && window.location.pathname.indexOf(dest) === -1) {
          window.location.href = dest;
        }
      }
    }
  }

  /* ── Custom pill dropdown ── */

  var CHEVRON = '<svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" ' +
    'class="dp-role-chevron" aria-hidden="true">' +
    '<path d="M4 6l4 4 4-4" stroke="currentColor" stroke-width="1.75" ' +
    'stroke-linecap="round" stroke-linejoin="round"/></svg>';

  function buildPicker() {
    var saved = getSaved();

    var picker = document.createElement('div');
    picker.className = 'dp-role-picker';
    picker.setAttribute('data-open', 'false');

    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'dp-role-trigger';
    btn.setAttribute('aria-haspopup', 'listbox');
    btn.setAttribute('aria-expanded', 'false');
    btn.setAttribute('aria-label', 'Switch role');

    var lbl = document.createElement('span');
    lbl.className = 'dp-role-trigger-label';
    lbl.textContent = getRole(saved).short;
    btn.appendChild(lbl);
    btn.insertAdjacentHTML('beforeend', CHEVRON);

    var list = document.createElement('ul');
    list.className = 'dp-role-dropdown';
    list.setAttribute('role', 'listbox');

    ROLES.forEach(function (r) {
      var li = document.createElement('li');
      li.className = 'dp-role-option';
      li.setAttribute('role', 'option');
      li.setAttribute('data-value', r.value);
      li.setAttribute('aria-selected', r.value === saved ? 'true' : 'false');
      li.textContent = r.full;
      li.addEventListener('click', function (e) {
        e.stopPropagation();
        closePicker(picker);
        applyRole(r.value, true);
      });
      list.appendChild(li);
    });

    picker.appendChild(btn);
    picker.appendChild(list);

    btn.addEventListener('click', function (e) {
      e.stopPropagation();
      var isOpen = picker.getAttribute('data-open') === 'true';
      document.querySelectorAll('.dp-role-picker[data-open="true"]').forEach(closePicker);
      if (!isOpen) openPicker(picker);
    });

    return picker;
  }

  function openPicker(picker) {
    picker.setAttribute('data-open', 'true');
    var btn = picker.querySelector('.dp-role-trigger');
    if (btn) btn.setAttribute('aria-expanded', 'true');
  }

  function closePicker(picker) {
    picker.setAttribute('data-open', 'false');
    var btn = picker.querySelector('.dp-role-trigger');
    if (btn) btn.setAttribute('aria-expanded', 'false');
  }

  document.addEventListener('click', function () {
    document.querySelectorAll('.dp-role-picker[data-open="true"]').forEach(closePicker);
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
      document.querySelectorAll('.dp-role-picker[data-open="true"]').forEach(closePicker);
    }
  });

  /* ── Header injection ── */

  function injectHeader() {
    if (document.querySelector('.dp-role-picker')) return;
    var inner = document.querySelector('.md-header__inner');
    if (!inner) return;
    var picker = buildPicker();
    var source = inner.querySelector('.md-header__source');
    source ? inner.insertBefore(picker, source) : inner.appendChild(picker);
  }

  /* ── Bind legacy inline selects ── */

  function bindInlineSelects() {
    document.querySelectorAll('.dp-role-select').forEach(function (sel) {
      if (sel.dataset.dpBound) return;
      sel.dataset.dpBound = '1';
      sel.addEventListener('change', function () { applyRole(this.value, true); });
    });
  }

  /* ── Init ── */

  function init() {
    injectHeader();
    applyRole(getSaved(), false);
    bindInlineSelects();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  if (typeof document$ !== 'undefined') {
    document$.subscribe(init);
  }
})();
