import { defineConfig } from 'vite';

// In development the site talks to the Django server through this proxy, so the
// browser sees one origin and no CORS is needed. In production the reverse proxy
// does the same job for /api.
export default defineConfig({
  // GitHub Pages serves a project site under /<repo>/; the workflow sets this.
  base: process.env.VITE_BASE ?? '/',
  server: {
    proxy: { '/api': process.env.SUMMA_API ?? 'http://localhost:8010' },
  },
  test: {
    environment: 'jsdom',
    include: ['tests/**/*.test.js'],
  },
});
