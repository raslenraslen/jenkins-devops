 ## 1️⃣ Les Pods :
Qu'est-ce qu'un Pod ?

Un Pod est une unité de base dans Kubernetes où les conteneurs sont exécutés.

Un pod peut contenir un ou plusieurs conteneurs, mais dans ce cas, on aura probablement un conteneur pour chaque application (Frontend, Backend, Database).

Problème des IP dynamiques :


Chaque Pod a une adresse IP interne. Cependant, cette adresse IP peut changer chaque fois qu'un Pod est redémarré ou recréé. Par exemple, si le Pod Frontend est supprimé puis recréé, il recevra une nouvelle IP.

Problème : Si d'autres Pods veulent communiquer avec lui via son IP, ils devront connaître la nouvelle IP. Mais comment le backend ou la base de données sauront-ils l'adresse IP du nouveau pod frontend ?

## 2️⃣ Les Services :

Qu'est-ce qu'un Service ?


Un Service est un objet Kubernetes qui fournit une adresse IP stable pour communiquer avec les Pods.
Chaque Pod peut être associé à un Service, et c'est ce Service qui sera utilisé pour la communication inter-Pods, pas l'IP des Pods eux-mêmes.
Scénario :

Imaginons que ton frontend doit communiquer avec le backend. Au lieu de communiquer directement via l'IP du Pod Backend (qui peut changer), il communique avec le Service Backend.
Si un Pod Backend est supprimé et un nouveau est créé, le Service Backend pointera toujours vers le nouveau Pod. Ainsi, même si l'IP change, la communication reste intacte.
Exemple :

Frontend Pod → frontend-service → Communique avec Backend Service via une IP stable.
Backend Pod → backend-service → Communique avec Database Service via une IP stable.


## 3️⃣ Les Secrets :

Qu'est-ce qu'un Secret ?

Un Secret dans Kubernetes est un objet utilisé pour stocker des informations sensibles (comme des mots de passe, des clés API, etc.).
Par exemple, si le Frontend doit se connecter à la Base de Données, il aura besoin du nom d'utilisateur et du mot de passe pour établir cette connexion. Ces informations ne doivent pas être stockées en clair dans les fichiers de configuration.
Scénario :

Le Frontend doit se connecter à la Base de Données, mais pour ce faire, il a besoin d'un nom d'utilisateur et d'un mot de passe. Ces informations sont stockées dans un Secret et sont injectées dans le Pod Frontend au moment de son démarrage.
Cela garantit que les informations sensibles (comme les mots de passe) ne sont pas exposées dans le code ou les fichiers de configuration.

Exemple :

Secret : Contient les informations sensibles pour accéder à la base de données (par exemple, db-user, db-password).
Le Frontend récupère ces informations via le Secret pour se connecter à la base de données.
