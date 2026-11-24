import bundle from '../content/landing.json';

import { ApiError } from './api.js';
import { LANGUAGE } from './locale.js';

const text = (value) => value?.[LANGUAGE] ?? '';

/** An exported CMS section as the public API serves it: `{ id, fields, children }`. */
function section(exported) {
  return {
    id: exported.slug,
    fields: (exported.fields ?? []).map((f) => ({ id: f.slug, value: text(f.values) })),
    children: (exported.children ?? []).map(section),
  };
}

/** Sample prices, clearly not live: the preview banner says so. */
export const SAMPLE_RATES = [
  ['GOLD18', '18k gold', 'gram', 4_100_000],
  ['COIN_EMAMI', 'Emami coin', 'coin', 47_500_000],
  ['USD', 'US dollar', 'USD', 62_000],
  ['EUR', 'Euro', 'EUR', 67_000],
  ['AED', 'UAE dirham', 'AED', 16_900],
  ['USDT', 'Tether', 'USDT', 62_100],
].map(([symbol, name, unit, price]) => ({ symbol, name, unit, price: String(price), known: true, stale: false }));

/**
 * The same methods as the real client, answered from the bundled content, so the
 * site can be shown (GitHub Pages) without a backend. The chat demo needs the
 * real parser, so it says so instead of pretending.
 */
export function createPreviewApi(content = bundle) {
  const pages = new Map(content.pages.map((p) => [p.slug, p]));
  const menus = new Map(content.menus.map((m) => [m.slug, m]));
  return {
    page: async (slug) => {
      const page = pages.get(slug);
      if (!page) throw new ApiError(404, 'not found');
      return { slug: page.slug, sections: page.sections.map(section) };
    },
    menu: async (name) => {
      const menu = menus.get(name);
      if (!menu) throw new ApiError(404, 'not found');
      return {
        items: menu.items.map((i) => ({ label: text(i.label), page: i.page, url: i.url ?? '', new_tab: Boolean(i.new_tab) })),
      };
    },
    plans: async () => [],
    rates: async () => SAMPLE_RATES,
    demo: async () => {
      throw new ApiError(0, 'preview', { preview: true });
    },
  };
}
