import { prefersReducedMotion } from './motion.js';

/**
 * Fade each top-level block of `root` in the first time it scrolls into view.
 * Without IntersectionObserver, or with reduced motion, everything just shows.
 * @param {HTMLElement} root
 */
export function revealOnScroll(root) {
  if (prefersReducedMotion() || typeof IntersectionObserver === 'undefined') return;
  const seen = new IntersectionObserver(
    (entries) => {
      for (const entry of entries) {
        if (!entry.isIntersecting) continue;
        entry.target.classList.add('in');
        seen.unobserve(entry.target);
      }
    },
    { threshold: 0.12 },
  );
  for (const block of root.children) {
    block.classList.add('reveal');
    seen.observe(block);
  }
}
