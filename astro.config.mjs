// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

// Site servi à la racine du sous-domaine ; SITE_URL et BASE_PATH ne servent qu'à un autre hébergement.
export default defineConfig({
  site: process.env.SITE_URL ?? 'https://vieux-comptoir.nedellec-julien.fr',
  base: process.env.BASE_PATH ?? '/',
  output: 'static',
  build: {
    inlineStylesheets: 'always',
  },
  vite: {
    plugins: [tailwindcss()],
  },
});
