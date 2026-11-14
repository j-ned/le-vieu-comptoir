# Image du site (nginx, fichiers statiques produits par Astro). Contexte de build : la racine du dépôt.
#   docker build -t vieux-comptoir-web .
# Aucune variable au démarrage : l'adresse du site est figée au build (astro.config.mjs).
FROM node:24-slim AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY astro.config.mjs tsconfig.json ./
COPY public public
COPY src src
RUN npm run build

FROM nginxinc/nginx-unprivileged:stable-alpine
COPY nginx/security-headers.conf /etc/nginx/vieux-comptoir/security-headers.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD ["wget", "-q", "-O", "/dev/null", "http://127.0.0.1:8080/"]
