<div style="text-align: center;">

# 🍷 Le Vieux Comptoir

### Site vitrine premium d'une brasserie parisienne — **fondée en 1892**

**Astro · Zéro JavaScript externe · Lighthouse 100 · Atmosphère intemporelle**

[![Astro](https://img.shields.io/badge/Astro-5-FF5D01?style=for-the-badge&logo=astro&logoColor=white)](https://astro.build)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178C6?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org)
[![Tailwind](https://img.shields.io/badge/Tailwind-v4-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white)](https://tailwindcss.com)
[![GitHub Pages](https://img.shields.io/badge/GitHub_Pages-deployed-222?style=for-the-badge&logo=github)](https://j-ned.github.io/le-vieu-comptoir/)

[**🔗 Site live**](https://j-ned.github.io/le-vieu-comptoir/) · [**📸 Captures**](#-captures-décran) · [**⚡ Performance**](#-performance)

![Le Vieux Comptoir — Hero](./screen/hero-dark.png)

</div>

---

## 📖 Sommaire

- [🎯 Le brief](#-le-brief)
- [🎨 Parti-pris design](#-parti-pris-design)
- [⚡ Performance](#-performance)
- [🧰 Stack technique](#-stack-technique)
- [🏗️ Architecture](#-architecture)
- [📸 Captures d'écran](#-captures-décran)
- [🚀 Installation](#-installation)

---

## 🎯 Le brief

Brasserie parisienne historique (**fondée en 1892**) — besoin d'une **vitrine haut de gamme** :

- Identité visuelle cohérente avec le positionnement (tradition, élégance, chaleur)
- Présentation de **l'établissement**, de **la carte**, du **fumoir**, et des **réservations**
- Performance mobile irréprochable (clientèle en déplacement)
- **Scores Lighthouse maximaux** — le SEO local est critique pour un restaurant
- Pas d'infrastructure serveur — déploiement statique

## 🎨 Parti-pris design

### Palette **bordeaux · or · crème**

Couleurs évoquant le bar à vin, les dorures d'un ancien comptoir, et la chaleur d'un intérieur Belle Époque.

| Couleur                   | Usage                          |
| ------------------------- | ------------------------------ |
| 🟥 **Bordeaux** `#600714` | CTAs, accents, prix            |
| 🟨 **Or** `#D4AF37`       | Titres de section, séparateurs |
| 🟪 **Crème** `#FDFBF7`    | Backgrounds chauds             |

### Typographie

- **Playfair Display** (Variable) — titres éditoriaux, serif classique
- **Inter** (Variable) — corps de texte, lisibilité maximale

### Effets

- **Glassmorphism** subtil sur les cartes (menu, horaires)
- **Parallaxe CSS** sur les images d'ambiance
- **Animations scroll-driven** natives (pas de lib JS)

---

## ⚡ Performance

### Objectifs atteints

| Metric             | Score        |
| ------------------ | ------------ |
| **Performance**    | 🎯 100 / 100 |
| **Accessibilité**  | 🎯 100 / 100 |
| **Best Practices** | 🎯 100 / 100 |
| **SEO**            | 🎯 100 / 100 |

### Comment on y arrive

1. **Astro Islands** — seuls les composants interactifs sont hydratés (ici : quasiment aucun)
2. **Zero JS externe** — rendu HTML/CSS pur, pas de Framework côté client
3. **Images AVIF** — conversion automatique via `astro:assets`, compression optimale
4. **Fonts auto-hébergées** — `@fontsource-variable/*`, pas de Google Fonts
5. **Preload critique** — hero image, fonts primaires
6. **No CLS** — dimensions explicites sur toutes les images
7. **Static site generation** — pré-rendu au build, déployé sur GitHub Pages (CDN)

### Bundle size

```
Total page weight  : ~180 KB (gzipped, hero inclus)
JS exécuté         : 0 KB (!)
```

---

## 🧰 Stack technique

### Framework

- **Astro 5** — SSG avec architecture islands
- **TypeScript 5** — strict mode
- **TailwindCSS v4** — thème custom (bordeaux / or / crème)

### Fonts

- **Playfair Display Variable** (titres)
- **Inter Variable** (corps)
- Auto-hébergées via `@fontsource-variable`

### Build & Deploy

- **Astro build** → static HTML + CSS + images optimisées
- **GitHub Actions** → pipeline CI automatique
- **GitHub Pages** → hébergement CDN gratuit

### Qualité

- **ESLint** (`eslint-plugin-astro`)
- **Prettier** avec `prettier-plugin-astro`

---

## 🏗️ Architecture

```
le-vieux-comptoir/
├── src/
│   ├── pages/             # index.astro (page unique, one-pager)
│   ├── layouts/           # Layout principal avec SEO meta + Open Graph
│   ├── components/        # Navbar, Hero, About, Menu, CigarLounge, Reservation, Reviews, Footer
│   ├── assets/            # images sources (AVIF auto-générées au build)
│   └── styles/            # global.css + theme Tailwind
├── public/                # favicon, og-image
├── astro.config.mjs       # config Astro + intégration Tailwind
└── .github/workflows/     # CI/CD GitHub Pages
```

---

## 📸 Captures d'écran

### Hero — Atmosphère Belle Époque

![Hero dark](./screen/hero-dark.png)

### Vue complète

![Full page](./screen/full-dark.png)

---

## 🚀 Installation

```bash
git clone https://github.com/j-ned/le-vieu-comptoir.git
cd le-vieu-comptoir
npm install
npm run dev
# → http://localhost:4321
```

### Build production

```bash
npm run build
npm run preview
```

### Déploiement automatique

Chaque push sur `master` déclenche le workflow GitHub Actions → build Astro → publication sur GitHub Pages.

---

<div style="text-align: center;">

**Développé par [Julien Nedellec](https://nedellec-julien.fr/)**

[![Portfolio](https://img.shields.io/badge/Portfolio-j--ned.dev-4f46e5?style=for-the-badge)](https://nedellec-julien.fr/)
[![GitHub](https://img.shields.io/badge/GitHub-j--ned-181717?style=for-the-badge&logo=github)](https://github.com/j-ned)

</div>
