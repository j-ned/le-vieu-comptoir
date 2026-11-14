# Déploiement sur le serveur (Dokploy) et bascule depuis Vercel

Le site est entièrement statique : ni base de données, ni API, ni variable d'environnement. La pile
de production est `compose.yaml`, un seul service nginx (`vieux-comptoir-web`). Dokploy ne construit
rien ; il tire l'image publiée sur GHCR par la CI (`vieux-comptoir-web`). Le trafic arrive par le
tunnel Cloudflare, puis le Traefik de Dokploy.

Tant que l'étape « Bascule » n'est pas faite, Vercel reste la production : tout ce qui précède est
sans impact.

## Mise en place (une fois)

1. **Paquet GHCR** : après la première CI sur `master`, le paquet `vieux-comptoir-web` doit être
   lisible par le serveur. Public, rien à faire ; privé, le registre `ghcr.io` déjà déclaré dans
   Dokploy pour Candidash (jeton `read:packages`) suffit s'il couvre le compte.
2. **Dokploy** : un projet (ou celui des démos), puis un service de type **Compose** dont la source
   est le dépôt : fournisseur **Git**, URL `https://github.com/j-ned/le-vieu-comptoir.git`, branche
   `master`, Compose Path `./deploy/compose.yaml` (la valeur par défaut, `./docker-compose.yml`,
   échoue avec « Compose file not found »). **Auto Deploy désactivé** : c'est la CI qui déclenche,
   une fois l'image publiée. Pas de mode **Raw** : il ignorerait le dépôt.
3. **Domains** : service `vieux-comptoir-web`, port `8080`, HTTP (le TLS est celui de Cloudflare),
   pour `vieux-comptoir.nedellec-julien.fr`. _Preview Compose_ doit montrer `vieux-comptoir-web` sur
   `dokploy-network`.
4. **Premier déploiement** à la main (bouton Deploy). Vérifier depuis le serveur, avant toute
   bascule, que Traefik sert le site :
   `curl -sI -H 'Host: vieux-comptoir.nedellec-julien.fr' http://127.0.0.1/` doit répondre `200`.
5. **Déclenchement par la CI** : secrets du dépôt `DOKPLOY_URL` (adresse du panneau, sans `/`
   final), `DOKPLOY_API_KEY`, `DOKPLOY_COMPOSE_ID` (dernier segment de l'URL du service),
   `CF_ACCESS_CLIENT_ID` et `CF_ACCESS_CLIENT_SECRET` (le jeton de service Cloudflare Access de
   Candidash peut être réutilisé). Variable facultative `DEPLOY_HEALTH_URL`
   (`https://vieux-comptoir.nedellec-julien.fr/`). Tant que les secrets Dokploy manquent, la CI
   publie l'image sans déployer.

## Bascule (pas de coupure : aucune donnée à copier)

1. Cloudflare → zone `nedellec-julien.fr` → DNS : supprimer l'enregistrement
   `vieux-comptoir` (CNAME vers `vercel-dns`, nuage gris).
2. Cloudflare → Zero Trust → tunnel du serveur → _Public Hostnames_ : ajouter
   `vieux-comptoir.nedellec-julien.fr` vers le même service que les autres sites du serveur (le
   Traefik de Dokploy). Cloudflare crée l'enregistrement DNS proxifié vers le tunnel.
3. Vérifier : `curl -sI https://vieux-comptoir.nedellec-julien.fr/` montre `server: cloudflare`
   (plus `server: Vercel`), les images s'affichent, la console du navigateur est sans erreur CSP.
4. Vercel → projet du site → _Settings_ → _Domains_ : retirer le domaine ; _Git_ : déconnecter le
   dépôt pour qu'il ne construise plus `master`.

Entre les étapes 1 et 2, le nom ne résout plus pendant quelques secondes à quelques minutes : site
de démonstration, sans conséquence.

## Retour arrière

Retirer le _Public Hostname_ du tunnel, recréer dans la zone DNS le CNAME vers Vercel (nuage gris)
et rattacher le domaine au projet Vercel, qui garde ses déploiements antérieurs.

## Retour à une version

Dans Environment, fixer `WEB_IMAGE=ghcr.io/j-ned/vieux-comptoir-web:sha-<commit>`, puis Deploy.

## Après une à deux semaines stables

Supprimer le projet Vercel. Désactiver GitHub Pages dans les réglages du dépôt (_Settings_ →
_Pages_) : le workflow qui le publiait est retiré, mais l'ancienne copie reste en ligne tant que
Pages est actif.
