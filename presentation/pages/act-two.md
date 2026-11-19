<div class="eyebrow">DÉFI 2 · FOLLOW THE BUILD</div>

# Le build part chez le voisin

<img class="release-evidence" src="/screenshots/release.png" alt="Workflow release : le job cabane-release utilise mathbuild-fe/vite-release-builder@v1." />

<img class="flag-two-evidence compact-flag" src="/screenshots/flag2.png" alt="Extrait du README de l’Action : Generated release information, suivi du deuxième flag." />
<div class="shot-caption">Le README de l’Action contenait le flag 2.</div>

<!--
Temps cible : 50 secondes.
Sources : ../../ma-cabane-auto/.github/workflows/release.yml, ../../vite-release-builder-auto/action.yml, ../solutions/flag2.md.
L’Action fait npm ci, npm run build, le marquage HTML, la validation de dist et le manifeste de build. Elle ne sert donc pas seulement à ajouter des métadonnées.
La CI ordinaire construit localement ; la release utilise cette Action sur le runner cabane-release. Transition : « Que fait cette Action aux fichiers générés ? »
-->

---

# Une « compatibilité » ajoutée au build

<div class="payload-evidence">
<img class="proof-image" src="/screenshots/payload.png" alt="stamp-release.js : téléchargement de client-compatibility.js, puis ajout aux fichiers dist/assets." />
<div class="proof-copy"><strong>Un ajout discret au build</strong><p>Sous prétexte de « compatibilité », l’Action télécharge un payload et l’ajoute au JavaScript livré.</p><strong>Watering hole attacks</strong><p>Piéger un site fréquenté par les cibles pour les atteindre lors de leur visite.</p><small>Ici, la supply chain permet de modifier le site de confiance.</small></div>
</div>

<!--
La capture payload.png montre le script de marquage et le téléchargement ajouté aux assets. Relier la compromission de la supply chain au principe des watering hole attacks : atteindre les visiteurs par un site de confiance.
Temps cible : 75 secondes.
Source : git show v1:scripts/stamp-release.js dans ../../vite-release-builder-auto ; ../../telemetry-wss-server/src/routes/client-compatibility.js ; ../../cabane-login-server/Dockerfile ; ../compose.yaml.
Le commit « Improve metadata compatibility with generated assets » ajoute un fetch HTTPS vers /release/client-compatibility.js, puis appendFileSync sur les JS/MJS sous dist/assets. Le payload complet vit dans le backend, pas dans l’Action. Le serveur le minifie et renseigne son hôte WSS.
Le Dockerfile frontend copie dist dans nginx ; le Dockerfile backend reprend ces fichiers dans une image Node, servie derrière Caddy. Aucune de ces copies ne reconstruit le frontend. Il faut donc aussi renouveler l’image backend pour livrer une correction.
Le navigateur envoie type, version du navigateur, pathname et timestamp. Il ne récupère pas de mots de passe ni de cookies. Transition : « Le payload a été glissé discrètement dans le build, sous couvert de compatibilité. Et pour le faire exécuter, aucun changement du workflow de la boutique : il suffit de déplacer le tag auquel elle fait confiance. »
-->

---

<div class="eyebrow">DÉFI 3 · MOVING TARGET</div>

# Même tag, code ajouté en douce

<img class="proof-image" style="max-height: 245px" src="/screenshots/git-refs.png" alt="Références et historique Git locaux : v1 et v1.3.0 restent au commit 94bad91, main est sur une version ultérieure." />

<div class="proof-caption">Le workflow garde <b>@v1</b>. Le tag est déplacé vers le commit compromis : <b>le payload entre dans la release sans modification du dépôt de la boutique.</b></div>

<!--
Capture des sorties Git locales, mises en forme pour la lecture. Les références et les messages de commit sont les valeurs réelles du dépôt généré.
Temps cible : 85 secondes.
Point central du récit : l’introduction discrète de code via une référence de confiance mutable. Dire : « La boutique n’a rien changé. Son workflow demande toujours v1, mais ce nom désigne maintenant le commit qui ajoute le payload. Une visite de main peut rassurer à tort : il faut examiner le commit réellement sélectionné par le tag. »
Vérifié dans l’historique local de ../../vite-release-builder-auto : v1 et v1.3.0 se résolvent vers 94bad9107b7e3b433e51d392dfe0fb68b9b98f1e, qui correspond à ../ctfd/flag3.yaml. Le commit suivant b94db69 retire l’ajout ; HEAD est 9306dee.
Ces dates et commits appartiennent à l’historique synthétique du challenge, pas à un incident réel observé. Le générateur ../../build-vite-release-builder-auto.sh montre les déplacements de v1 ; la présence actuelle d’un tag seule ne prouve pas ses déplacements passés.
Un tag v1.0.0 est lui aussi déplaçable : il est conservé sur la version propre dans ce scénario. Transition : « L’historique révèle aussi une clé oubliée. »
-->

---

<div class="eyebrow">DÉFI 4 · GHOSTS IN HISTORY</div>

# Une clé oubliée sous le paillasson

<img class="proof-image" style="max-height: 250px" src="/screenshots/bad-fix.png" alt="Commit 7f28f95 : suppression de .env.production et ajout au .gitignore ; le token reste visible dans le diff." />
<div class="takeaway">Supprimer le fichier et l’ignorer ne révoque pas le token : il reste dans l’historique.</div>

<!--
Capture du commit de suppression : le diff expose encore le token synthétique du challenge.
Temps cible : 40 secondes.
Sources : ../solutions/flag4.md ; historique local de ../../vite-release-builder-auto : 71add18 ajoute le faux secret, 7f28f95 le retire. C’est un secret synthétique dont la valeur est le flag.
Dire : « On sait comment le code est arrivé en production. Mais comment aurait-on pu prendre la main sur l’Action ? Dans l’historique, on retrouve une clé oubliée. Si ce token était encore valide et avait les bons droits, il aurait pu jouer un rôle dans la compromission. »
Cette piste est une hypothèse narrative : aucune preuve locale n’établit l’utilisation, la validité ou les permissions du token. Le secret de l’exercice reste synthétique. Rappeler oralement que supprimer un fichier ne révoque pas un jeton.
Transition : « Cette clé donne une origine possible à l’incident. La popup, elle, nous emmène vers l’infrastructure qui se trouve derrière. »
-->
