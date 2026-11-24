import { el } from './dom.js';
import { icon } from './icons.js';

/** `{ headline: "...", cta: "..." }` from a CMS section's fields. */
export function fieldMap(section) {
  return Object.fromEntries((section?.fields ?? []).map((f) => [f.id, f.value]));
}

const section = (page, id) => (page.sections ?? []).find((s) => s.id === id);

/** Every section opens the same way: a rule, then the heading. */
export function heading(title) {
  return el('header', { class: 'section-head' }, el('h2', {}, title ?? ''));
}

/** An item card (icon + title + body) for a child section. */
function card(child) {
  const f = fieldMap(child);
  return el('article', { class: 'card glass' }, icon(child.id), el('h3', {}, f.title ?? ''), el('p', {}, f.body ?? ''));
}

/** The hero text block for the home page. The interactive scale sits beside it. */
export function renderHero(page) {
  const f = fieldMap(section(page, 'hero'));
  return el(
    'div',
    { class: 'hero-text' },
    el('h1', {}, f.headline ?? ''),
    el('p', { class: 'lead' }, f.subtitle ?? ''),
    el(
      'div',
      { class: 'hero-actions' },
      el('a', { class: 'button', href: '#demo' }, f.cta ?? ''),
      el('a', { class: 'button ghost', href: '#features' }, 'See the features'),
    ),
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
        heading(fieldMap(how).title),
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
        heading(fieldMap(features).title),
        el('div', { class: 'grid' }, ...(features.children ?? []).map(card)),
      ),
    );
  }
  const privacy = section(page, 'privacy');
  if (privacy) {
    const f = fieldMap(privacy);
    out.push(
      el(
        'section',
        { id: 'privacy', class: 'glass block' },
        icon('privacy'),
        el('h2', {}, f.title ?? ''),
        el('p', {}, f.body ?? ''),
      ),
    );
  }
  return out;
}

/** FAQ as native disclosure widgets: keyboard accessible with no script. */
export function renderFaq(page) {
  const questions = section(page, 'questions');
  return el(
    'section',
    { id: 'faq' },
    heading(fieldMap(questions).title),
    el(
      'div',
      { class: 'faq-list' },
      ...(questions?.children ?? []).map((c) => {
        const f = fieldMap(c);
        return el('details', { class: 'glass' }, el('summary', {}, f.title ?? ''), el('p', {}, f.body ?? ''));
      }),
    ),
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
