---
class: section-slide
---

<div class="eyebrow">CHANGEMENT DE PERSPECTIVE</div>

# Blue Team → Red Team

Nous avons retracé la compromission du build.<br>Nous explorons maintenant les failles du serveur de l’attaquant.

<div class="takeaway">La connexion WSS devient le point de départ de la reconnaissance.</div>

<!--
Temps cible : 20 secondes.
Marquer le changement de posture : de l’analyse de l’incident à l’exploration offensive de l’infrastructure prévue pour le CTF.
-->

---

<div class="eyebrow">DÉFI 5 · THE DEBUG TRAIL</div>

# La popup mène à son serveur

<div class="evidence-trail">Hôte WSS de l’attaquant <span>→</span> fuzzing des chemins <span>→</span> /swagger</div>

Tester les chemins de <code>endpoint-wordlist.txt</code> sur l’URL HTTPS de l’attaquant : chaque entrée remplace <code>FUZZ</code>.

```bash
ffuf -w endpoint-wordlist.txt -u https://telemetricks.challenges.bnctf.com/FUZZ
```

<img class="proof-image" style="max-height: 180px" src="/screenshots/swagger-detail.png" alt="Capture de Swagger : GET /admin/connections et le cinquième flag dans sa description." />
<div class="proof-caption">La documentation révèle le <b>flag 5</b> et une route administrative.</div>

<!--
Capture réelle du bloc GET /admin/connections dans Swagger sur l’instance locale. Le cadrage privilégie la route et sa description.
Temps cible : 50 secondes.
Sources : ../solutions/flag5.md, ../ctfd/flag5.yaml et ../README.md.
La cause de la compromission du build est expliquée ; le challenge se prolonge dans son infrastructure. La wordlist guide vers /swagger. Le champ summary de GET /admin/connections contient le flag 5. Exposer une documentation ne suffit pas à contourner une authentification : la faille vient ensuite. Transition : « La route prétend demander un jeton. Mais le garde et le routeur ne lisent pas la même chose. »
-->

---

<div class="eyebrow">DÉFI 6 · HACKERS HACKED</div>

# Une URL, deux interprétations

<div class="eyebrow">REQUÊTES SANS JETON · RÉPONSES HTTP LOCALES</div>

```http
GET /admin/connections     → 401 Unauthorized
GET /%61dmin/connections   → 200 OK
```

<div class="takeaway">La seconde requête renvoie la liste des connexions : flag, nom d’utilisateur et empreinte du mot de passe.</div>
<div class="proof-caption"><b>Contrôle :</b> chemin brut <span>→</span> <b>Routage :</b> chemin décodé<br><code>%61</code> devient <code>a</code> : même destination, contrôle contourné.</div>

<!--
Statuts HTTP repris de la capture api-evidence.png. Le contenu de la réponse est détaillé sur la diapositive suivante.
Temps cible : 70 secondes.
Source : ../solutions/flag6.md. %61 est l’encodage du caractère a.
Expliquer l’ordre exact : test sur le chemin brut, puis décodage, puis recherche de route. Vérification locale du gestionnaire avec des données factices : /admin/connections sans jeton → 401 ; /%61dmin/connections sans jeton → 200. Pas de validation du service distant.
Les données étaient préchargées pour le challenge, pas collectées auprès des visiteurs. Le sixième flag était dans le champ version. Transition : « Cet enregistrement préparait aussi la dernière étape. »
-->

---

<div class="eyebrow">DÉFI 7 · BACK TO THE CABANE</div>

# Le dernier indice ferme la boucle

<div class="shot-caption">Extrait de la réponse JSON à <code>GET /%61dmin/connections</code> — instance locale capturée.</div>

```json
{
  "version": "BNCTF{b2d7b880-7736-42ac-a6bf-2a6315637954}",
  "username": "Julien",
  "password": "0716a5cea0577995508b18acd9a590bd"
}
```

<img class="proof-image" style="max-height: 115px; margin: .5rem auto" src="/screenshots/md5.png" alt="Recherche de l’empreinte MD5 0716a5cea0577995508b18acd9a590bd : le résultat indique le mot de passe complexpassword." />
<div class="proof-caption">MD5 → <b>complexpassword</b> → connexion à Ma Cabane → flag 7.</div>


<!--
Extrait transcrit de api-evidence.png : le compte de cette instance est Julien. Le champ password contient une empreinte MD5, pas le mot de passe en clair. La capture md5.png retrouve complexpassword pour cette empreinte. Ne pas confondre ces valeurs avec celles de la solution par défaut ci-dessous.
Temps cible : 50 secondes.
Sources : ../solutions/flag7.md ; ../../telemetry-wss-server/src/server.js ; ../../cabane-login-server/server.js ; ../compose.yaml.
Le compte de la solution est thelkdo et le mot de passe hello there. Compose transmet les mêmes LOGIN_USERNAME et LOGIN_PASSWORD au backend et au serveur de télémétrie, qui en précharge le MD5. Le lien entre les deux services est donc construit explicitement pour le CTF.
On ne « déchiffre » pas MD5 : on compare les empreintes de candidats jusqu’à retrouver le mot de passe.
Les valeurs présentées sont celles de la solution ; elles peuvent différer selon la configuration de l’instance.
-->
