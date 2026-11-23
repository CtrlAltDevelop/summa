export class ApiError extends Error {
  constructor(status, message, { preview = false } = {}) {
    super(message);
    this.status = status;
    /** True when there is no backend at all (the static preview). */
    this.preview = preview;
  }
}

/**
 * A small client for the public endpoints. The backend wraps every answer as
 * `{ data, errors }`; this unwraps it and turns a failure into an ApiError.
 * @param {typeof fetch} fetchImpl
 * @param {string} base
 */
export function createApi(fetchImpl = globalThis.fetch.bind(globalThis), base = '/api/v1') {
  async function call(path, options) {
    let response;
    try {
      response = await fetchImpl(`${base}${path}`, options);
    } catch {
      throw new ApiError(0, 'offline');
    }
    let body = null;
    try {
      body = await response.json();
    } catch {
      /* not JSON: handled below */
    }
    if (!response.ok) {
      const message = body?.errors?.[0] ?? body?.message ?? `HTTP ${response.status}`;
      throw new ApiError(response.status, String(message));
    }
    return body?.data;
  }

  return {
    page: (slug) => call(`/cms/pages/${encodeURIComponent(slug)}?language=fa`),
    menu: (name) => call(`/cms/menus/${encodeURIComponent(name)}?language=fa`),
    plans: () => call('/billing/plans'),
    rates: () => call('/assets/rates'),
    demo: (text) =>
      call('/assistant/demo', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ text }),
      }),
  };
}
