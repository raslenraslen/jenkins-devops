# Problème : Port déjà utilisé par Jenkins

## Contexte

Lorsque vous exécutez une application dans un conteneur Docker, elle peut par défaut écouter sur le port **8080** à l'intérieur du conteneur. Si un autre service (comme Jenkins) utilise déjà ce port sur l'hôte, un conflit se produit et l'application ne peut pas être atteinte.

---

## Erreur Observée

**Conflit de port :**
- Jenkins utilise le port **8080** sur l’hôte.
- Votre application essaie d’être accessible sur le même port, ce qui empêche la connexion.

**Message potentiel :**
```
ERR_CONNECTION_REFUSED
```
---

## Solution Appliquée

**Mapper le port interne 8080 vers un autre port sur l'hôte :**

Utilisez l’option `-p` de Docker pour attribuer un port différent sur l’hôte.

**Exemple :**
```bash
docker run -d --name application -p 8082:8080 application
```

**Ce que cela fait :**
- L’application continue d’écouter sur **8080** à l’intérieur du conteneur.
- Mais elle est accessible via **8082** depuis l’hôte.
- Jenkins reste sur **8080**, aucun conflit ne se produit.

---

## Résultat

Après avoir utilisé `-p 8082:8080` :
- Jenkins et l’application fonctionnent simultanément.
- Vous accédez à Jenkins via `http://localhost:8080`.
- Vous accédez à l’application via `http://localhost:8082`.

---

**Résumé :**
- Le conflit de port a été résolu en changeant le port d’accès depuis l’hôte, tout en gardant la configuration interne du conteneur inchangée.
