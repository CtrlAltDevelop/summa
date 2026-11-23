/** True when the person asked the system for less motion. */
export function prefersReducedMotion(win = globalThis.window) {
  return Boolean(win?.matchMedia?.('(prefers-reduced-motion: reduce)').matches);
}
