# Faire confiance à du code externe

Dans Ma Cabane, personne n’a modifié le code de la boutique.

<div class="act-list compact">
<div><b>1</b><div><strong>Le build dépend d’une Action tierce</strong><small>Elle peut modifier les fichiers qui seront livrés aux clients.</small></div></div>
<div><b>2</b><div><strong>Cette Action est compromise</strong><small>Le tag v1 pointe vers du code qui ajoute le payload.</small></div></div>
<div><b>3</b><div><strong>La prochaine release embarque ce code</strong><small>Le dépôt de la boutique et son workflow n’ont pas changé.</small></div></div>
</div>

<div class="takeaway">Épingler les Actions au SHA complet d’un commit vérifié.<br>Un tag peut être déplacé vers un autre commit.</div>

<!--
Temps cible : 65 secondes.
Dire : « Nous n’avons pas besoin de modifier notre code pour introduire un risque. Une Action, une dépendance ou un script externe fait aussi partie de ce que nous exécutons et livrons. Dans Ma Cabane, le code React reste intact : c’est l’Action tierce qui ajoute le payload au build. La confiance doit donc couvrir toute la chaîne de livraison. »
À développer à l’oral : revoir les Actions et les scripts téléchargés, épingler un SHA revu, reconstruire les images et déployer par digest. Ces mesures sont proposées, pas présentées comme déjà appliquées. Un SHA fixe une référence mais ne sécurise pas un script externe téléchargé sans contrôle. Protéger les tags et limiter les privilèges du runner complète la réponse.
Ne pas affirmer que v1 est la seule référence mutable : les workflows locaux utilisent également des tags pour checkout et les Actions Docker. Les tags Docker, même nommés comme un SHA Git, restent déplaçables ; le digest identifie le contenu.
Pour l’API, l’autorisation doit porter sur la route effectivement résolue. Pour les mots de passe, employer un hachage adapté plutôt que MD5.
-->

---
class: closing-slide
---

<div class="eyebrow">À RETENIR</div>

# Le sirop était bon.<br>Le build, moins.

Un dépôt propre ne garantit pas un artefact propre.

<div class="closing-question">Questions ?</div>

<!--
Temps cible : 30 secondes.
Conclure : « Le piège était de vérifier le code que l’on voyait, plutôt que le code réellement exécuté et livré. »
Ouvrir les questions sans supposer que le public a joué. Le récit couvre les sept flags en environ 12 min 50 ; il reste 1 à 2 minutes pour échanger.
-->
