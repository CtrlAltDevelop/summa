import { describe, expect, it, vi } from 'vitest';

import { ApiError, createApi } from '../src/api.js';

const reply = (status, body) => ({ ok: status < 400, status, json: async () => body });

describe('createApi', () => {
  it('unwraps the data of a successful answer', async () => {
    const fetchImpl = vi.fn().mockResolvedValue(reply(200, { data: [{ code: 'monthly' }], errors: null }));

    const plans = await createApi(fetchImpl, '/api/v1').plans();

    expect(plans).toEqual([{ code: 'monthly' }]);
    expect(fetchImpl).toHaveBeenCalledWith('/api/v1/billing/plans', undefined);
  });

  it('asks for the site language and escapes the slug', async () => {
    const fetchImpl = vi.fn().mockResolvedValue(reply(200, { data: {} }));

    await createApi(fetchImpl).page('a b');

    expect(fetchImpl.mock.calls[0][0]).toBe('/api/v1/cms/pages/a%20b?language=en');
  });

  it('posts the demo sentence as JSON', async () => {
    const fetchImpl = vi.fn().mockResolvedValue(reply(200, { data: { reply: 'x', card: null } }));

    await createApi(fetchImpl).demo('۲۵۰ هزار تومن نان');

    const [url, options] = fetchImpl.mock.calls[0];
    expect(url).toBe('/api/v1/assistant/demo');
    expect(options.method).toBe('POST');
    expect(JSON.parse(options.body)).toEqual({ text: '۲۵۰ هزار تومن نان' });
  });

  it('turns an error status into an ApiError carrying the status', async () => {
    const fetchImpl = vi.fn().mockResolvedValue(reply(429, { errors: ['Too many tries.'] }));

    await expect(createApi(fetchImpl).demo('x')).rejects.toMatchObject({
      name: 'Error',
      status: 429,
      message: 'Too many tries.',
    });
  });

  it('survives an error that is not JSON', async () => {
    const fetchImpl = vi.fn().mockResolvedValue({
      ok: false,
      status: 502,
      json: async () => {
        throw new SyntaxError('bad json');
      },
    });

    await expect(createApi(fetchImpl).rates()).rejects.toMatchObject({ status: 502, message: 'HTTP 502' });
  });

  it('reports a dead connection as status 0', async () => {
    const fetchImpl = vi.fn().mockRejectedValue(new TypeError('network'));

    const error = await createApi(fetchImpl).plans().catch((e) => e);

    expect(error).toBeInstanceOf(ApiError);
    expect(error.status).toBe(0);
  });
});
