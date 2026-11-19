---
class: screenshot-slide
---

# Tout commence par une notification

<div class="symptom-proof">
<img class="symptom-site" src="/screenshots/popup.png" alt="La notification sur la boutique du challenge." />
<div class="symptom-zoom"><span>LA NOTIFICATION, EN DÉTAIL</span><img src="/screenshots/popup-detail.png" alt="Agrandissement de la notification de session expirée." /></div>
</div>
<div class="shot-caption">Visible en production, absente du code React et du build local.</div>

<!--
Temps cible : 45 secondes.
Dire : « Les clients voient une notification de session expirée. En local, le frontend ne la reproduit pas. » La capture montre le symptôme, pas une fenêtre de vol d’identifiants. Le texte est rendu avec textContent et le seul contrôle est le bouton de fermeture. Le délai est propre à chaque connexion : 3 secondes par défaut dans compose.yaml, 30 dans le serveur seul.
Capture réelle de l’instance Docker locale, prise avec Chromium.
-->

---

<div class="eyebrow">DÉFI 1 · PRODUCTION ONLY</div>

# Le HTML donne le premier flag

<div class="repo-evidence">
<div><img class="proof-image" src="/screenshots/html-evidence.png" alt="Métadonnées HTML : flag, dépôt, révision et version du build." /><p><code>build-repository</code> indique le dépôt à examiner.</p></div>
<img class="proof-image" src="/screenshots/ma-cabane-git.png" alt="Dépôt Git ma-cabane-a-sucre : source React et répertoire .github/workflows." />
</div>
<div class="proof-caption"><b>Flag 1</b> dans le HTML · <b>build-repository</b> mène au dépôt source.</div>

<!--
Capture d’un extrait de la réponse HTML réellement reçue de l’instance locale, mis en forme pour la projection. Les valeurs ne sont pas reconstituées.
Temps cible : 45 secondes.
Source : ../solutions/flag1.md ; nom et points : ../ctfd/flag1.yaml.
Le flag et les métadonnées sont visibles dans la capture de l’extrait HTML.
Ce marquage est ajouté lors de la release, pas par le build Vite local seul. Transition : « Le HTML nous ramène au dépôt. Le workflow, lui, nous en fait sortir. »
-->
