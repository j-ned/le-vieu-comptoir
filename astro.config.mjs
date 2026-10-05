// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

// Site servi à la racine du sous-domaine ; le workflow GitHub Pages surcharge les deux valeurs.
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
