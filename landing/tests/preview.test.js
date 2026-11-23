import { describe, expect, it } from 'vitest';

import { messageFor } from '../src/demo.js';
import { renderFaq, renderHomeSections, renderMenu } from '../src/content.js';
import { createPreviewApi } from '../src/preview.js';

describe('static preview api', () => {
  const api = createPreviewApi();

  it('serves the bundled home page in the shape the renderers read', async () => {
    const page = await api.page('home');

    const [how, features, privacy] = renderHomeSections(page);
    expect(how.querySelectorAll('li').length).toBeGreaterThan(0);
    expect(features.querySelectorAll('.card').length).toBeGreaterThan(0);
    expect(privacy).toBeTruthy();
  });

  it('serves the FAQ and the menus', async () => {
    expect((await api.page('faq')) && renderFaq(await api.page('faq')).querySelectorAll('details').length).toBeGreaterThan(0);
    const links = renderMenu(await api.menu('main'));
    expect(links.map((a) => a.getAttribute('href'))).toContain('#/');
  });

  it('refuses a page that is not bundled', async () => {
    await expect(api.page('nope')).rejects.toMatchObject({ status: 404 });
  });

  it('lists sample prices and no plans', async () => {
    expect((await api.rates()).every((r) => r.known)).toBe(true);
    expect(await api.plans()).toEqual([]);
  });

  it('explains that the chat demo needs the backend', async () => {
    const error = await api.demo('x').catch((e) => e);

    expect(messageFor(error)).toContain('نسخهٔ نمایشی');
  });
});
