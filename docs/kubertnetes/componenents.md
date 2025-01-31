## 1️⃣ Les Pods :

Les Pods sont l'unité de base dans Kubernetes. Un pod peut contenir un ou plusieurs conteneurs (par exemple, une application frontend ou backend).
Problème : Si un pod est supprimé et recréé, il aura une nouvelle adresse IP. Cela pose un problème pour la communication, car les autres pods ne connaissent pas cette nouvelle adresse IP.

