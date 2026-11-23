import '@fontsource-variable/vazirmatn';
import { createApi } from './api.js';
import { renderFaq, renderHero, renderHomeSections, renderMenu, renderTextPage } from './content.js';
import { createDemo } from './demo.js';
import { el } from './dom.js';
import { renderPlans, renderRates } from './prices.js';
import { revealOnScroll } from './reveal.js';
import { renderTools } from './tools.js';

const api = createApi();
const app = document.getElementById('app');

/** Show a failure in place of a section instead of leaving the page blank. */
const unavailable = () => el('p', { class: 'muted' }, 'این بخش فعلاً در دسترس نیست.');

async function safe(promise, render) {
  try {
    return render(await promise);
  } catch {
    return unavailable();
  }
}

async function home() {
  const canvas = el('canvas', { class: 'scale', 'aria-label': 'ترازوی حساب‌وکتاب', role: 'img' });
  // Three.js is the heavy part: load it after the text, and live without it if
  // it cannot load or WebGL is missing.
  const scale = await import('./hero.js').then((m) => m.createScale(canvas)).catch(() => null);
  const demo = createDemo(api, scale);
  const [page, rates, plans, faq] = [api.page('home'), api.rates(), api.plans(), api.page('faq')];

  const hero = await safe(page, (p) =>
    el('section', { class: 'hero' }, renderHero(p), el('div', { class: 'stage' }, scale ? canvas : null)),
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
  footer.replaceChildren(...renderMenu(foot));
}

window.addEventListener('hashchange', route);
chrome();
route();
