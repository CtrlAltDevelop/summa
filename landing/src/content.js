import { el } from './dom.js';

/** `{ headline: "...", cta: "..." }` from a CMS section's fields. */
export function fieldMap(section) {
  return Object.fromEntries((section?.fields ?? []).map((f) => [f.id, f.value]));
}

const section = (page, id) => (page.sections ?? []).find((s) => s.id === id);

/** An item card (title + body) for a child section. */
function card(child) {
  const f = fieldMap(child);
  return el('article', { class: 'card glass' }, el('h3', {}, f.title ?? ''), el('p', {}, f.body ?? ''));
}

/** The hero text block for the home page. The interactive scale sits beside it. */
export function renderHero(page) {
  const f = fieldMap(section(page, 'hero'));
  return el(
    'div',
    { class: 'hero-text' },
    el('h1', {}, f.headline ?? ''),
    el('p', { class: 'lead' }, f.subtitle ?? ''),
    el('a', { class: 'button', href: '#demo' }, f.cta ?? ''),
  );
}

/** The remaining home sections: how it works, features, privacy. */
export function renderHomeSections(page) {
  const out = [];
  const how = section(page, 'how');
  if (how) {
    out.push(
      el(
        'section',
        { id: 'how' },
        el('h2', {}, fieldMap(how).title ?? ''),
        el('ol', { class: 'steps' }, ...(how.children ?? []).map((c) => el('li', { class: 'glass' }, card(c)))),
      ),
    );
  }
  const features = section(page, 'features');
  if (features) {
    out.push(
      el(
        'section',
        { id: 'features' },
        el('h2', {}, fieldMap(features).title ?? ''),
        el('div', { class: 'grid' }, ...(features.children ?? []).map(card)),
      ),
    );
  }
  const privacy = section(page, 'privacy');
  if (privacy) {
    const f = fieldMap(privacy);
    out.push(el('section', { id: 'privacy', class: 'glass block' }, el('h2', {}, f.title ?? ''), el('p', {}, f.body ?? '')));
  }
  return out;
}

/** FAQ as native disclosure widgets: keyboard accessible with no script. */
export function renderFaq(page) {
  const questions = section(page, 'questions');
  return el(
    'section',
    { id: 'faq' },
    el('h2', {}, fieldMap(questions).title ?? ''),
    ...(questions?.children ?? []).map((c) => {
      const f = fieldMap(c);
      return el('details', { class: 'glass' }, el('summary', {}, f.title ?? ''), el('p', {}, f.body ?? ''));
    }),
  );
}

/** A plain text page (about, privacy, terms). */
export function renderTextPage(page) {
  const f = fieldMap(section(page, 'content'));
  return el('article', { class: 'glass block text-page' }, el('h1', {}, f.title ?? ''), el('p', {}, f.body ?? ''));
}

/** Where a menu item points inside this single-page site. */
export function linkOf(item) {
  if (item.url) return item.url;
  return item.page === 'home' ? '#/' : `#/page/${item.page}`;
}

export function renderMenu(menu) {
  return (menu?.items ?? []).map((item) =>
    el('a', { href: linkOf(item), target: item.new_tab ? '_blank' : false, rel: item.new_tab ? 'noopener' : false }, item.label),
  );
}
