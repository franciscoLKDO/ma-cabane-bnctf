# Ma Cabane — présentation en français

Présentation Slidev récapitulative du CTF Ma Cabane, créé par Franck Holé pour BNCTF. Inspirée du découpage en actes et des cartes visuelles du deck Mercury, avec du papier crème, des carreaux de flanelle rouge et des feuilles d’érable. Format : 16 diapositives, environ 12 min 50 de récit et 1 à 2 minutes de questions (10 à 15 minutes selon le rythme). Le public ne joue pas : le deck raconte le scénario, explique les solutions et en tire les enseignements, sans manipulation requise.

## Lancer

Avec Node.js >= 22.12 et npm :

```bash
npm ci
npm run dev
```

`npm run build` génère le site statique dans `dist/`. `npm run export` permet l’export PDF si Playwright et son navigateur sont installés.

## Rythme

Les notes indiquent un temps cible par diapositive : 12 min 50 au total, puis 1 à 2 minutes de questions. Le minuteur Slidev est réglé sur 13 minutes.

| Slides | Partie | Durée |
| --- | --- | --- |
| 1–4 | Couverture, présentateur, contexte et choix de la track | 2 min 25 |
| 5–6 | Symptôme et piste dans le HTML | 1 min 30 |
| 7–10 | Action, injection, tag compromis et secret Git | 4 min 10 |
| 11 | Transition Blue Team → Red Team | 20 s |
| 12–14 | Serveur, contournement et connexion finale | 2 min 50 |
| 15–16 | Enseignements et conclusion | 1 min 35 |

Pour tenir 10 minutes, raccourcir les commentaires sur l’introduction, les métadonnées, le secret dans Git et la connexion finale. Préserver l’explication du tag et du contrôle d’accès. Aucun terminal ni exercice en direct n’est prévu.

Le fil du récit est la différence entre le code visible et le code exécuté : le frontend est propre, puis main paraît propre, alors que v1 sélectionne toujours le commit compromis. Les flags servent de repères dans l’enquête ; les points ne sont pas affichés.

## Organisation

- `slides.md` : couverture et assemblage.
- `pages/introduction.md` : présentateur, contexte du challenge et motivation de la track.
- `pages/act-one.md` : observation du site et défi 1.
- `pages/act-two.md` : chaîne de livraison, Git et défis 2 à 4.
- `pages/act-three.md` : télémétrie, API et défis 5 à 7.
- `pages/conclusion.md` : mesures de protection et conclusion.
- `style.css` : thème visuel local, sans police ni image distante.
- `public/screenshots/` : captures réelles du site, de la popup, de Swagger et du formulaire.
- `public/art/maple.svg` : feuille d’érable vectorielle.

Les commentaires Markdown contiennent les notes du présentateur, les sources et les explications du parcours. Le deck révèle les solutions, le commit attendu et les identifiants pédagogiques de l’étape finale ; il est destiné au débrief. Les valeurs complètes des flags ne sont pas nécessaires au parcours.

## Sources et préparation

La slide « Pourquoi une track supply chain ? » relie la motivation du créateur à la campagne Trivy de février–mars 2026, documentée par [Aqua Security](https://www.aquasec.com/blog/trivy-supply-chain-attack-what-you-need-to-know/), et aux [recommandations GitHub sur les Actions tierces](https://docs.github.com/en/actions/reference/security/secure-use#using-third-party-actions). Sources consultées le 17 novembre 2026. Le CTF transpose le mécanisme des tags déplacés ; il ne reproduit pas toutes les étapes de l’incident réel.

Le contenu repose sur `../README.md`, `../solutions/flag1.md` à `flag7.md` et `../ctfd/flag1.yaml` à `flag7.yaml`. Les sept défis totalisent 575 points. Le SHA de l’étape 3 est confirmé à la fois par CTFd et par les tags locaux v1/v1.3.0 de `../../vite-release-builder-auto`. Le générateur `../../build-vite-release-builder-auto.sh` explique la chronologie synthétique. Les dépôts sans suffixe auto servent aussi de sources de travail et peuvent différer de cette histoire.

Les captures ont été prises sur les services Docker locaux, démarrés avec `docker compose -f ../compose.yaml up -d backend telemetry-ws-server caddy`. Le runner GitHub n’est pas démarré. Chromium résout les deux noms de domaine du challenge vers 127.0.0.1 et accepte les certificats locaux ; le DNS du système n’est pas modifié. Le compte rendu de capture indique environ 30 secondes ; le serveur seul a ce délai par défaut, tandis que le Compose actuel le remplace par 3 secondes. Les captures ne sont pas des maquettes. Les captures et extraits servent de support au récapitulatif ; aucune instance active ni démonstration en direct n’est requise. Les identifiants affichés sont ceux des solutions.

Les précisions techniques ont été recoupées avec les scripts de marquage de release, le client et le gestionnaire HTTP de `../../telemetry-wss-server`, le Dockerfile et le serveur de `../../cabane-login-server`, et `../compose.yaml`. Les données de connexion sont préchargées pour le CTF. L’usage effectif du faux token GitHub n’est pas établi. L’état des dépôts distants et des images déployées n’a pas été vérifié.

Le parcours reste lisible sans service en ligne : commandes illustratives, explications et preuves figurent dans les diapositives.

Pour arrêter les services démarrés pour les captures :

```bash
docker compose -f ../compose.yaml stop backend telemetry-ws-server caddy
```
