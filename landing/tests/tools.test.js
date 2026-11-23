// @vitest-environment jsdom
import { describe, expect, it } from 'vitest';
import { renderTools, TEXT } from '../src/tools.js';

const type = (node, value) => {
  node.value = value;
  node.dispatchEvent(new Event('input', { bubbles: true }));
};

describe('renderTools', () => {
  const rates = [
    { name: 'دلار', price: '100', known: true },
    { name: 'سکه', price: '50', known: true },
    { name: 'نامعلوم', price: '0', known: false },
  ];
  it('computes a loan from Persian digits', () => {
    const root = renderTools(rates);
    const [loan] = root.querySelectorAll('article');
    const [a, r, m] = loan.querySelectorAll('input');
    type(a, '۱۲۰۰'); type(r, '0'); type(m, '12');
    expect(loan.querySelector('.result').textContent).toContain('۱۰۰');
  });
  it('shows a hint for bad input and skips unknown rates', () => {
    const root = renderTools(rates);
    const [, save, conv] = root.querySelectorAll('article');
    type(save.querySelector('input'), 'x');
    expect(save.querySelector('.result').textContent).toBe(TEXT.invalid);
    expect(conv.querySelectorAll('option')).toHaveLength(4);
  });
  it('omits the converter without rates', () => {
    expect(renderTools([]).querySelectorAll('article')).toHaveLength(2);
  });
});
