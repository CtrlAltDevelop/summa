const NS = 'http://www.w3.org/2000/svg';

/** One line-art glyph per feature, keyed by the CMS section slug. */
const PATHS = {
  wallets: ['M4 7h13a3 3 0 0 1 3 3v6a3 3 0 0 1-3 3H6a2 2 0 0 1-2-2V7Z', 'M4 7a2 2 0 0 1 2-2h9', 'M16.5 13h.5'],
  budgets: ['M5 17a7 7 0 1 1 14 0', 'M12 17l4-5'],
  debts: ['M5 4h14v16l-3-2-2 2-2-2-2 2-3-2V4Z', 'M9 9h6', 'M9 13h4'],
  assets: ['M4 19h16', 'M7 15l4-5 3 3 5-7'],
  offline: ['M8 3h8a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1Z', 'M9.5 16l2 2 3.5-4'],
  privacy: ['M7 11V8a5 5 0 0 1 10 0v3', 'M5 11h14v9H5z'],
  default: ['M12 4l8 8-8 8-8-8z'],
};

/**
 * An inline SVG glyph. Decorative: the card's own heading carries the meaning,
 * so it is hidden from assistive tech.
 * @param {string} name
 */
export function icon(name) {
  const svg = document.createElementNS(NS, 'svg');
  svg.setAttribute('class', 'icon');
  svg.setAttribute('viewBox', '0 0 24 24');
  svg.setAttribute('aria-hidden', 'true');
  svg.setAttribute('focusable', 'false');
  for (const d of PATHS[name] ?? PATHS.default) {
    const path = document.createElementNS(NS, 'path');
    path.setAttribute('d', d);
    svg.append(path);
  }
  return svg;
}
