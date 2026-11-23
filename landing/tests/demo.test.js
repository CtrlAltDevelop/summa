import { describe, expect, it, vi } from 'vitest';

import { ApiError } from '../src/api.js';
import { tilt } from '../src/balance.js';
import { MESSAGES, createDemo, messageFor } from '../src/demo.js';

const card = (kind, amount_minor, currency = 'IRT') => ({ kind, amount_minor, currency });

async function say(demo, text) {
  demo.root.querySelector('input').value = text;
  demo.root.querySelector('form').dispatchEvent(new Event('submit', { cancelable: true }));
  await vi.waitFor(() => expect(demo.root.querySelector('button[type=submit]').disabled).toBe(false));
}

describe('the live demo', () => {
  it('shows the sentence and the answer, and offers to register a card', async () => {
    const api = { demo: vi.fn().mockResolvedValue({ reply: 'این را ثبت کنم؟', card: card('expense', 250000) }) };
    const demo = createDemo(api, null);

    await say(demo, '۲۵۰ هزار تومن خرید نان');

    const bubbles = [...demo.root.querySelectorAll('.bubble')].map((b) => b.className.split(' ')[1]);
    expect(bubbles).toEqual(['me', 'bot']);
    expect(api.demo).toHaveBeenCalledWith('۲۵۰ هزار تومن خرید نان');
    expect(demo.root.querySelector('.bot button').textContent).toBe(MESSAGES.register);
  });

  it('registering moves the totals and tips the scale', async () => {
    const scale = { setTilt: vi.fn() };
    const api = { demo: vi.fn().mockResolvedValue({ reply: 'x', card: card('income', 900) }) };
    const demo = createDemo(api, scale);
    expect(scale.setTilt).toHaveBeenLastCalledWith(0);

    await say(demo, 'حقوق');
    demo.root.querySelector('.bot button').click();

    expect(demo.account.income).toBe(900);
    expect(scale.setTilt).toHaveBeenLastCalledWith(tilt(900, 0));
    expect(demo.root.querySelector('.done').textContent).toBe(MESSAGES.registered);
    expect(demo.root.querySelector('.totals').textContent).toContain('۹۰۰');
  });

  it('an expense tips the other way', async () => {
    const scale = { setTilt: vi.fn() };
    const api = { demo: vi.fn().mockResolvedValue({ reply: 'x', card: card('expense', 500) }) };
    const demo = createDemo(api, scale);

    await say(demo, 'نان');
    demo.root.querySelector('.bot button').click();

    expect(scale.setTilt).toHaveBeenLastCalledWith(tilt(0, 500));
    expect(tilt(0, 500)).toBeLessThan(0);
  });

  it('a registered card cannot be registered twice', async () => {
    const api = { demo: vi.fn().mockResolvedValue({ reply: 'x', card: card('expense', 500) }) };
    const demo = createDemo(api, null);

    await say(demo, 'نان');
    demo.root.querySelector('.bot button').click();

    expect(demo.root.querySelector('.bot button')).toBeNull();
    expect(demo.account.expense).toBe(500);
  });

  it('offers no register button for a transfer, a foreign currency or no card', async () => {
    for (const answer of [
      { reply: 'x', card: card('transfer', 900) },
      { reply: 'x', card: card('expense', 900, 'USD') },
      { reply: 'کمک', card: null },
    ]) {
      const demo = createDemo({ demo: vi.fn().mockResolvedValue(answer) }, null);
      await say(demo, 'متن');
      expect(demo.root.querySelector('.bot button')).toBeNull();
    }
  });

  it('says what went wrong in Persian and stays usable', async () => {
    const api = { demo: vi.fn().mockRejectedValue(new ApiError(429, 'x')) };
    const demo = createDemo(api, null);

    await say(demo, 'متن');

    expect(demo.root.querySelector('.error').textContent).toBe(MESSAGES.rate);
    expect(demo.root.querySelector('button[type=submit]').disabled).toBe(false);
  });

  it('ignores an empty submission', async () => {
    const api = { demo: vi.fn() };
    const demo = createDemo(api, null);
    demo.root.querySelector('input').value = '   ';

    demo.root.querySelector('form').dispatchEvent(new Event('submit', { cancelable: true }));

    expect(api.demo).not.toHaveBeenCalled();
    expect(demo.root.querySelectorAll('.bubble')).toHaveLength(0);
  });

  it.each([
    [new ApiError(0, 'offline'), MESSAGES.offline],
    [new ApiError(429, 'x'), MESSAGES.rate],
    [new ApiError(500, 'x'), MESSAGES.generic],
    [new Error('boom'), MESSAGES.generic],
  ])('messageFor %#', (error, expected) => {
    expect(messageFor(error)).toBe(expected);
  });
});
