import { describe, expect, it } from 'vitest';

import { fieldMap, linkOf, renderFaq, renderHero, renderHomeSections, renderMenu, renderTextPage } from '../src/content.js';

const f = (id, value) => ({ id, value });
const child = (id, title, body) => ({ id, fields: [f('title', title), f('body', body)] });

const home = {
  sections: [
    { id: 'hero', fields: [f('headline', 'تیتر'), f('subtitle', 'زیرتیتر'), f('cta', 'شروع')] },
    { id: 'how', fields: [f('title', 'چطور؟')], children: [child('a', 'یک', 'الف'), child('b', 'دو', 'ب')] },
    { id: 'features', fields: [f('title', 'ویژگی‌ها')], children: [child('w', 'کیف', 'متن')] },
    { id: 'privacy', fields: [f('title', 'حریم'), f('body', 'متن حریم')] },
  ],
};

describe('content rendering', () => {
  it('maps fields by id', () => {
    expect(fieldMap(home.sections[0])).toEqual({ headline: 'تیتر', subtitle: 'زیرتیتر', cta: 'شروع' });
    expect(fieldMap(undefined)).toEqual({});
  });

  it('renders the hero with a link to the demo', () => {
    const hero = renderHero(home);

    expect(hero.querySelector('h1').textContent).toBe('تیتر');
    expect(hero.querySelector('a').getAttribute('href')).toBe('#demo');
    expect(hero.querySelector('a').textContent).toBe('شروع');
  });

  it('renders the steps, the features and the privacy block', () => {
    const [how, features, privacy] = renderHomeSections(home);

    expect(how.querySelectorAll('li')).toHaveLength(2);
    expect(features.querySelectorAll('.card')).toHaveLength(1);
    expect(privacy.textContent).toContain('متن حریم');
  });

  it('skips sections the page does not have', () => {
    expect(renderHomeSections({ sections: [] })).toEqual([]);
  });

  it('renders the FAQ as disclosure widgets', () => {
    const faq = renderFaq({ sections: [{ id: 'questions', fields: [f('title', 'سؤال‌ها')], children: [child('q', 'چرا؟', 'چون')] }] });

    expect(faq.querySelector('details summary').textContent).toBe('چرا؟');
    expect(faq.querySelector('details p').textContent).toBe('چون');
  });

  it('renders a text page', () => {
    const page = renderTextPage({ sections: [{ id: 'content', fields: [f('title', 'درباره'), f('body', 'متن')] }] });

    expect(page.querySelector('h1').textContent).toBe('درباره');
    expect(page.querySelector('p').textContent).toBe('متن');
  });

  it('treats editor text as text, never as markup', () => {
    const page = renderTextPage({
      sections: [{ id: 'content', fields: [f('title', '<img src=x onerror=alert(1)>'), f('body', '<b>bold</b>')] }],
    });

    expect(page.querySelector('img')).toBeNull();
    expect(page.querySelector('b')).toBeNull();
    expect(page.textContent).toContain('<b>bold</b>');
  });

  it('links menu items inside the site, or out to a url', () => {
    expect(linkOf({ page: 'home' })).toBe('#/');
    expect(linkOf({ page: 'faq' })).toBe('#/page/faq');
    expect(linkOf({ page: null, url: 'https://example.com' })).toBe('https://example.com');
  });

  it('renders a menu, opening new tabs safely', () => {
    const links = renderMenu({
      items: [
        { label: 'خانه', page: 'home' },
        { label: 'بیرون', url: 'https://example.com', new_tab: true },
      ],
    });

    expect(links.map((a) => a.textContent)).toEqual(['خانه', 'بیرون']);
    expect(links[1].getAttribute('target')).toBe('_blank');
    expect(links[1].getAttribute('rel')).toBe('noopener');
    expect(links[0].getAttribute('target')).toBeNull();
    expect(renderMenu(null)).toEqual([]);
  });
});
