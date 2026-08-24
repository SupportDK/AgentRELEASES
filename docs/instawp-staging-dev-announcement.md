# InstaWP Staging Auto-Deploy — Dev Announcement

## English

**TL;DR — Our premium plugins now auto-deploy to InstaWP staging sites on every push to `main`. Nothing changes in your normal workflow; do not hand-edit the `deploy-instawp` branch.**

### What we set up
We wired a GitHub → InstaWP staging pipeline so QA can always test the latest build of a premium plugin without anyone packaging or uploading a ZIP by hand.

### How it works
- Each premium repo has a dedicated **`deploy-instawp`** branch. This branch is **generated, not hand-written** — it always mirrors the current `main` plus a fully built `vendor/` folder.
- A GitHub webhook fires when `deploy-instawp` is updated; InstaWP then pulls that branch straight into the plugin folder of the staging site.
- For plugins that use Composer (Action Scheduler, etc.), **`vendor/` is committed into `deploy-instawp`** so InstaWP does not have to run `composer install`. This is deliberate — a missing `vendor/` was the one thing that caused a white screen during the pilot.
- Destination folder on staging = the plugin's **Text Domain / install slug**, so in-place updates behave exactly like a real install.

### Scope
- **In scope:** premium plugins only (those that deploy to `wpconnect.co`).
- **Out of scope:** free / WordPress.org plugins and the WPForms add-ons — those are not deployed to InstaWP.
- **Pilot (done, fully automated):** TimeTonic WP Sync, GF TimeTonic, wpDataTables Airtable.
- **Rolling out now (9 plugins):** Air WP Sync Pro+, Air Woo Sync, Notion WP Sync Pro+, Sync Woo Orders to Odoo, GF Airtable, GF Notion, GF Odoo, GF SendGrid, GF Brevo.

### What this means for you
- **Your normal flow is unchanged.** Keep working on `feature/*` and `release/*`; the production release pipeline (`release/* → main → wpconnect.co`) is untouched.
- **Do NOT commit to or edit `deploy-instawp`.** It is force-updated automatically and any manual change will be overwritten.
- **Do not add `composer install` as an InstaWP post-deploy command** — `vendor/` is already bundled; running it again only breaks the deploy.
- After your PR merges to `main`, the matching staging site refreshes on its own within a minute or two. If a staging site doesn't update, ping us — it's usually a webhook/deploy-key issue on the infra side, not your code.

### Reminder for GF / environment-gated repos
If a repo's `Prod` GitHub Environment has a custom deployment-branch policy, merge-to-`main` deploys get rejected (the merge ref never matches `release/*`). We keep that policy set to `null`, aligned across all repos — please don't re-add a branch restriction on the environment.

---

## Français

**En bref — Nos plugins premium se déploient désormais automatiquement sur les sites de staging InstaWP à chaque push sur `main`. Rien ne change dans votre flux habituel ; ne modifiez pas la branche `deploy-instawp` à la main.**

### Ce que nous avons mis en place
Nous avons connecté un pipeline GitHub → InstaWP staging pour que la QA puisse toujours tester la dernière version d'un plugin premium, sans que personne ait à empaqueter ou téléverser un ZIP manuellement.

### Comment ça fonctionne
- Chaque dépôt premium possède une branche dédiée **`deploy-instawp`**. Cette branche est **générée, pas écrite à la main** — elle reflète toujours le `main` actuel plus un dossier `vendor/` entièrement construit.
- Un webhook GitHub se déclenche quand `deploy-instawp` est mise à jour ; InstaWP récupère alors cette branche directement dans le dossier du plugin sur le site de staging.
- Pour les plugins qui utilisent Composer (Action Scheduler, etc.), le dossier **`vendor/` est committé dans `deploy-instawp`** afin qu'InstaWP n'ait pas à exécuter `composer install`. C'est volontaire — un `vendor/` manquant est précisément ce qui a provoqué un écran blanc pendant le pilote.
- Le dossier de destination sur le staging = le **Text Domain / slug d'installation** du plugin, pour que les mises à jour se comportent exactement comme une vraie installation.

### Périmètre
- **Inclus :** uniquement les plugins premium (ceux déployés sur `wpconnect.co`).
- **Exclus :** les plugins gratuits / WordPress.org et les add-ons WPForms — ils ne sont pas déployés sur InstaWP.
- **Pilote (terminé, entièrement automatisé) :** TimeTonic WP Sync, GF TimeTonic, wpDataTables Airtable.
- **En cours de déploiement (9 plugins) :** Air WP Sync Pro+, Air Woo Sync, Notion WP Sync Pro+, Sync Woo Orders to Odoo, GF Airtable, GF Notion, GF Odoo, GF SendGrid, GF Brevo.

### Ce que cela implique pour vous
- **Votre flux habituel ne change pas.** Continuez à travailler sur `feature/*` et `release/*` ; le pipeline de release en production (`release/* → main → wpconnect.co`) n'est pas modifié.
- **Ne committez pas sur `deploy-instawp` et ne la modifiez pas.** Elle est mise à jour automatiquement en force-push et toute modification manuelle sera écrasée.
- **N'ajoutez pas `composer install` comme commande post-déploiement InstaWP** — le `vendor/` est déjà inclus ; le relancer ne fait que casser le déploiement.
- Après le merge de votre PR sur `main`, le site de staging correspondant se rafraîchit tout seul en une ou deux minutes. Si un site de staging ne se met pas à jour, prévenez-nous — c'est généralement un problème de webhook / deploy-key côté infra, pas votre code.

### Rappel pour les dépôts GF / avec environnement verrouillé
Si l'environnement GitHub `Prod` d'un dépôt a une politique de branche de déploiement personnalisée, les déploiements au merge sur `main` sont rejetés (la ref de merge ne correspond jamais à `release/*`). Nous gardons cette politique à `null`, de façon homogène sur tous les dépôts — merci de ne pas réintroduire de restriction de branche sur l'environnement.
