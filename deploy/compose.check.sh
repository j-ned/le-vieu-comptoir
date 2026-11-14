#!/usr/bin/env bash
# Valide `compose.yaml` avant qu'il parte en production : Dokploy lit ce fichier dans le dépôt à
# chaque déploiement, donc un fichier invalide fusionné serait déployé tel quel.
#   deploy/compose.check.sh
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

services="$(docker compose -f "$HERE/compose.yaml" config --services | sort | paste -sd' ')"
test "$services" = "vieux-comptoir-web" || { echo "services inattendus : $services" >&2; exit 1; }
echo "compose.yaml valide, services : $services"
