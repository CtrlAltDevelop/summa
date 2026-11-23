import { afterEach, describe, expect, it, vi } from 'vitest';

import { revealOnScroll } from '../src/reveal.js';

function page() {
  const root = document.createElement('main');
  root.append(document.createElement('section'), document.createElement('section'));
  return root;
}

afterEach(() => vi.unstubAllGlobals());

describe('revealOnScroll', () => {
  it('shows blocks as they enter the viewport and stops watching them', () => {
    let notify;
    const unobserve = vi.fn();
    vi.stubGlobal(
      'IntersectionObserver',
      class {
        constructor(callback) { notify = callback; }
        observe() {}
        unobserve(target) { unobserve(target); }
      },
    );
    const root = page();
    revealOnScroll(root);
    const [first, second] = root.children;
    expect(first.classList.contains('reveal')).toBe(true);
    expect(first.classList.contains('in')).toBe(false);

    notify([{ target: first, isIntersecting: true }, { target: second, isIntersecting: false }]);

    expect(first.classList.contains('in')).toBe(true);
    expect(second.classList.contains('in')).toBe(false);
    expect(unobserve).toHaveBeenCalledWith(first);
  });

  it('leaves everything visible without IntersectionObserver', () => {
    vi.stubGlobal('IntersectionObserver', undefined);
    const root = page();
    revealOnScroll(root);
    expect([...root.children].some((c) => c.classList.contains('reveal'))).toBe(false);
  });

  it('leaves everything visible when the person wants less motion', () => {
    vi.stubGlobal('matchMedia', () => ({ matches: true }));
    vi.stubGlobal('IntersectionObserver', class { observe() {} unobserve() {} });
    const root = page();
    revealOnScroll(root);
    expect([...root.children].some((c) => c.classList.contains('reveal'))).toBe(false);
  });
});
