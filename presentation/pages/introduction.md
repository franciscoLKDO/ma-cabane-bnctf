# Salut!

<div class="profile">
<div><div class="eyebrow">CRÉATEUR DU CHALLENGE</div><div class="display-name">Franck Holé</div></div>
<div class="card"><p>Domaine Cartes</p><p>Développeur backend</p></div>
</div>

<!--
Temps cible : 20 secondes.
Biographie reprise de la présentation Mercury. Ma Cabane a été créé pour BNCTF.
-->

---

# C’est quoi, Ma Cabane ?

<div class="eyebrow">UN CHALLENGE BLUE TEAM · SEPT FLAGS</div>
<div class="proof-columns intro-proof">
<div><img class="proof-image" src="/screenshots/site-detail.png" alt="La boutique de sirop d’érable du challenge, capturée sur l’instance locale." /></div>
<div class="proof-copy"><strong>Une boutique, un incident</strong><p>Une notification apparaît en production. Le frontend semble pourtant propre.</p><strong>Le fil de l’enquête</strong><p>Comprendre ce qui a réellement été construit et livré.</p></div>
</div>

<!--
Temps cible : 45 secondes.
Source : ../README.md, présentation et objectifs pédagogiques. Dire : « Je vais vous raconter comment les sept étapes se reliaient, et surtout où se cachait la compromission. » Le public n’a pas besoin d’avoir joué. Les étapes finales prolongent le scénario vers les faiblesses du serveur de télémétrie.
-->

---

# Pourquoi une track supply chain ?

<div class="eyebrow">DÉBUT 2026 · LA CI/CD DANS LE VISEUR</div>

<div class="grid-two">
<div class="card"><strong>Trivy · Aqua Security</strong><p>Une campagne commencée fin février, puis une nouvelle compromission le 19 mars 2026.</p><p>Des tags d’Actions déplacés vers du code malveillant : même référence, autre code exécuté.</p></div>
<div class="card"><strong>La consigne : épingler les SHA</strong><p>GitHub recommande un SHA de commit complet pour les Actions tierces.</p><p>Choisir un commit revu et vérifier son origine, puis maîtriser ses mises à jour.</p></div>
</div>

<div class="takeaway">L’objectif de Ma Cabane : rendre concret le « pourquoi » derrière la consigne SHA plutôt que tag.</div>

<div class="shot-caption">Sources : <a href="https://www.aquasec.com/blog/trivy-supply-chain-attack-what-you-need-to-know/">Retour d’incident Aqua</a> · <a href="https://docs.github.com/en/actions/reference/security/secure-use#using-third-party-actions">Recommandations GitHub</a></div>

<!--
Temps cible : 60 secondes.
Motivation donnée par le créateur : le début d’année chargé en attaques supply chain et les consignes d’utiliser des SHA de commits plutôt que des tags ont inspiré cette track.
Dire : « On nous demande d’épingler les Actions sur des SHA. Je voulais que le challenge fasse comprendre ce que cette règle empêche, avec un cas concret. »
Aqua documente une première intrusion fin février 2026, puis le 19 mars une release Trivy 0.69.4 malveillante et le déplacement de tags de trivy-action et setup-trivy. L’incident réel ciblait notamment les secrets CI/CD ; Ma Cabane transpose le mécanisme de confiance dans un tag en injection contrôlée dans le frontend. Ce n’est pas une reproduction exacte de Trivy.
La documentation actuelle privilégie également les lockfiles de dépendances de workflows ; elle recommande l’épinglage SHA aux dépôts qui ne les adoptent pas. La recommandation GitHub n’est pas née de cet incident : il en illustre l’intérêt. Un SHA complet empêche qu’un déplacement de tag change le commit sélectionné ; il ne garantit pas que ce commit ou ses téléchargements sont sûrs. Vérifier que le commit appartient au dépôt d’origine et revoir les mises à jour.
Sources officielles consultées le 17 novembre 2026 : https://www.aquasec.com/blog/trivy-supply-chain-attack-what-you-need-to-know/ et https://docs.github.com/en/actions/reference/security/secure-use#using-third-party-actions.
Transition : « Dans Ma Cabane, cette confiance détournée commençait par un symptôme très banal. »
-->
