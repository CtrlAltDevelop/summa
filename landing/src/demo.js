import { emptyAccount, register, tilt } from './balance.js';
import { el } from './dom.js';
import { formatNumber } from './format.js';

export const MESSAGES = {
  offline: 'اتصال برقرار نشد. اینترنت را بررسی کن.',
  rate: 'چند بار پشت‌سر هم امتحان کردی؛ کمی صبر کن.',
  generic: 'مشکلی پیش آمد. دوباره امتحان کن.',
  placeholder: 'مثلاً: ۲۵۰ هزار تومن خرید نان',
  registered: 'ثبت شد',
  register: 'ثبت',
  income: 'درآمد',
  expense: 'خرج',
  send: 'ارسال',
};

/** The sentence for an API failure. */
export function messageFor(error) {
  if (error?.status === 0) return MESSAGES.offline;
  if (error?.status === 429) return MESSAGES.rate;
  return MESSAGES.generic;
}

/**
 * The live chat demo: the visitor types a sentence, the real parser on the server
 * answers with a card, and registering it moves the balance scale. Nothing is
 * stored; the "account" lives only in this page.
 * @param {{demo:(text:string)=>Promise<any>}} api
 * @param {{setTilt:(angle:number)=>void}|null} scale
 */
export function createDemo(api, scale) {
  let account = emptyAccount();
  const log = el('div', { class: 'log', role: 'log', 'aria-live': 'polite' });
  const totals = el('p', { class: 'totals' });
  const input = el('input', { type: 'text', maxlength: 200, placeholder: MESSAGES.placeholder, 'aria-label': 'جمله‌ات را بنویس' });
  const send = el('button', { type: 'submit', class: 'button' }, MESSAGES.send);
  const form = el('form', { class: 'composer' }, input, send);

  function paint() {
    totals.textContent = `${MESSAGES.income}: ${formatNumber(account.income)} · ${MESSAGES.expense}: ${formatNumber(account.expense)}`;
    scale?.setTilt(tilt(account.income, account.expense));
  }

  function bubble(text, who) {
    const node = el('div', { class: `bubble ${who}` }, text);
    log.append(node);
    return node;
  }

  function cardNode(card) {
    const button = el('button', { type: 'button', class: 'button small' }, MESSAGES.register);
    button.addEventListener('click', () => {
      account = register(account, card);
      button.replaceWith(el('span', { class: 'done' }, MESSAGES.registered));
      paint();
    });
    return button;
  }

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    const text = input.value.trim();
    if (!text) return;
    input.value = '';
    bubble(text, 'me');
    send.disabled = true;
    try {
      const answer = await api.demo(text);
      const node = bubble(answer.reply, 'bot');
      // Only toman cards move the scale: its totals are in toman, and a transfer
      // changes neither side.
      const movesScale = answer.card && answer.card.kind !== 'transfer' && answer.card.currency === 'IRT';
      if (movesScale) node.append(cardNode(answer.card));
    } catch (error) {
      bubble(messageFor(error), 'error');
    } finally {
      send.disabled = false;
      input.focus();
    }
  });

  paint();
  const root = el('div', { class: 'demo glass' }, totals, log, form);
  return { root, get account() { return account; } };
}
