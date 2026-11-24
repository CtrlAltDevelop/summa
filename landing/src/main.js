import '@fontsource-variable/vazirmatn';
import { createApi } from './api.js';
import { renderFaq, renderHero, renderHomeSections, renderMenu, renderTextPage } from './content.js';
import { createDemo } from './demo.js';
import { el } from './dom.js';
import { renderPlans, renderRates } from './prices.js';
import { revealOnScroll } from './reveal.js';
import { renderTools } from './tools.js';

// The static preview (GitHub Pages) has no backend: it answers from bundled content.
const preview = import.meta.env.VITE_PREVIEW === '1';
const api = preview ? (await import('./preview.js')).createPreviewApi() : createApi();
if (preview) {
  document.body.prepend(
    el(
      'p',
      { class: 'preview-banner', role: 'note' },
      'Static preview: the prices are samples and the chat demo needs the backend. ',
      el('a', { href: 'https://github.com/CtrlAltDevelop/summa', rel: 'noopener' }, 'Source on GitHub'),
    ),
  );
}
const app = document.getElementById('app');

/** Show a failure in place of a section instead of leaving the page blank. */
const unavailable = () => el('p', { class: 'muted' }, 'This section is unavailable right now.');

async function safe(promise, render) {
  try {
    return render(await promise);
  } catch {
    return unavailable();
  }
}

async function home() {
  const canvas = el('canvas', { class: 'scale', 'aria-label': 'A balance scale that tips with the demo account', role: 'img' });
  // Three.js is the heavy part: load it after the text, and live without it if
  // it cannot load or WebGL is missing.
  const scale = await import('./hero.js').then((m) => m.createScale(canvas)).catch(() => null);
  const demo = createDemo(api, scale);
  const [page, rates, plans, faq] = [api.page('home'), api.rates(), api.plans(), api.page('faq')];

  const hero = await safe(page, (p) =>
    el('section', { class: 'hero' }, renderHero(p), el('div', { class: 'stage' }, el('div', { class: 'stage-glow', 'aria-hidden': true }), scale ? canvas : null)),
  );
  app.replaceChildren(
    hero,
    el('section', { id: 'demo' }, demo.root),
    ...(await safe(page, (p) => renderHomeSections(p)).then((r) => (Array.isArray(r) ? r : [r]))),
    await safe(rates, renderRates),
    await safe(rates.catch(() => []), renderTools),
    await safe(plans, renderPlans),
    await safe(faq, renderFaq),
  );
  revealOnScroll(app);
}

async function textPage(slug) {
  app.replaceChildren(await safe(api.page(slug), renderTextPage));
  revealOnScroll(app);
}

function route() {
  const match = location.hash.match(/^#\/page\/([\w-]+)$/);
  return match ? textPage(match[1]) : home();
}

async function chrome() {
  const nav = document.getElementById('nav');
  const footer = document.getElementById('footer');
  const [main, foot] = await Promise.all([
    api.menu('main').catch(() => null),
    api.menu('footer').catch(() => null),
  ]);
  nav.replaceChildren(...renderMenu(main));
  footer.replaceChildren(...renderMenu(foot), el('span', { class: 'copyright' }, `© ${new Date().getFullYear()} Summa`));
}

window.addEventListener('hashchange', route);
chrome();
route();
