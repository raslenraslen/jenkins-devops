# Docker Workflow and Concepts

## **Introduction**

Docker est un outil qui permet de **créer**, **déployer** et **exécuter des applications** dans des environnements isolés appelés **conteneurs**. Ce guide explique les concepts principaux de Docker, étape par étape, avec des explications simples.

Docker est une plateforme open-source qui permet d'automatiser le déploiement, la mise à l'échelle et la gestion des applications en utilisant la conteneurisation. Les conteneurs offrent une manière légère et portable de packager les applications et leurs dépendances, garantissant leur exécution cohérente dans différents environnements.

---

## **Dockerfile**

Un **Dockerfile** est un fichier texte qui contient les instructions nécessaires pour construire une image Docker. Voici les parties principales d'un Dockerfile :

### **1. FROM**

```dockerfile
FROM openjdk:17-jdk-alpine
```

- **Description :**
  - Utilise une image Docker de base (ici, Java 17 avec Alpine Linux).
  - Alpine est un mini-système d'exploitation léger.
- **Pourquoi ?**
  - Fournit un environnement avec Java pour exécuter l'application.

### **2. EXPOSE**

```dockerfile
EXPOSE 8070
```

- **Description :**
  - Ouvre le port **8070** dans le conteneur pour recevoir des connexions.
- **Pourquoi ?**
  - Permet à l'application de communiquer avec l'extérieur via ce port.

### **3. ENV**

```dockerfile
ENV APP_HOME /usr/src/app
```

- **Description :**
  - Crée une variable d'environnement `APP_HOME` qui pointe vers `/usr/src/app`.
- **Pourquoi ?**
  - Organise le code en définissant un chemin principal pour l'application.

### **4. COPY**

```dockerfile
COPY target/shopping-cart-0.0.1-SNAPSHOT.jar $APP_HOME/app.jar
```

- **Description :**
  - Copie le fichier JAR (application Java) dans le répertoire `/usr/src/app` du conteneur.
  - Renomme le fichier en `app.jar`.
- **Pourquoi ?**
  - Met l'application dans le conteneur pour qu'elle puisse être exécutée.

### **5. WORKDIR**

```dockerfile
WORKDIR $APP_HOME
```

- **Description :**
  - Définit `/usr/src/app` comme répertoire courant dans le conteneur.
- **Pourquoi ?**
  - Facilite l'exécution des commandes à partir du bon répertoire.

### **6. ENTRYPOINT**

```dockerfile
ENTRYPOINT exec java -jar app.jar
```

- **Description :**
  - Configure la commande par défaut qui démarre l'application.
  - `java -jar app.jar` exécute l'application Java dans le conteneur.
- **Pourquoi ?**
  - Lance automatiquement l'application dès que le conteneur démarre.

---

## **Pipeline Jenkins avec Docker**

### **Stage 1 : Build Docker Image**

```groovy
stage('Build Docker Image') {
    steps {
        script {
            withDockerRegistry(credentialsId: 'c9b058e5-bfe6-41f8-9b5d-dc0b0d2955ac', toolName: 'docker') {
                sh "docker build -t shopping-cart -f docker/Dockerfile ."
                sh "docker tag shopping-cart Raslen/shopping-cart:latest"
            }
        }
    }
}
```

- **Explications :**
  1. **`docker build`** : Construit une image Docker à partir du Dockerfile.
     - **`-t shopping-cart`** : Nomme l'image `shopping-cart`.
     - **`-f docker/Dockerfile`** : Spécifie le chemin du Dockerfile.
  2. **`docker tag`** : Ajoute un tag (`Raslen/shopping-cart:latest`) pour pousser l'image sur Docker Hub.

---

### **Stage 2 : Push Docker Image**

```groovy
stage('Push Docker Image') {
    steps {
        script {
            withDockerRegistry(credentialsId: 'c9b058e5-bfe6-41f8-9b5d-dc0b0d2955ac', toolName: 'docker') {
                sh "docker push Raslen/shopping-cart:latest"
            }
        }
    }
}
```

- **Explications :**
  1. **`docker push`** : Envoie l'image Docker taggée vers Docker Hub.
  2. **Pourquoi ?**
     - Cela rend l'image accessible pour d'autres équipes ou environnements.

---

### **Stage 3 : Deploy To Docker Container**

```groovy
stage('Deploy To Docker Container') {
    steps {
        script {
            withDockerRegistry(credentialsId: 'c9b058e5-bfe6-41f8-9b5d-dc0b0d2955ac', toolName: 'docker') {
                sh "docker run -d --name shopping -p 8070:8070 Raslen/shopping-cart:latest"
            }
        }
    }
}
```

- **Explications :**
  1. **`docker run`** : Lance un conteneur basé sur l'image Docker.
     - **`-d`** : Mode détaché (en arrière-plan).
     - **`--name shopping`** : Nomme le conteneur `shopping`.
     - **`-p 8070:8070`** : Lie le port 8070 du conteneur au port 8070 de la machine hôte.
  2. **Pourquoi ?**
     - Cela démarre l'application et la rend accessible sur **[http://localhost:8070](http://localhost:8070)**.

---

## **Concepts Clés**

### **Tag dans Docker**

- Un **tag** est une étiquette pour identifier une version spécifique d'une image.
- Exemple :
  - `Raslen/shopping-cart:latest` → Dernière version.
  - `Raslen/shopping-cart:v1.0` → Version 1.0.

### **Avec ou sans `/` dans le tag**

- **Avec `/`** :
  - Indique à Docker qu’il s’agit d’une image appartenant à un utilisateur ou une organisation.
  - Exemple : `Raslen/shopping-cart:latest`.
- **Sans `/`** :
  - Docker considère que l’image est locale à la machine.
  - Exemple : `shopping-cart:latest` (non lié à Docker Hub).

### **Docker et les Credentials Jenkins**

- **Comment Docker connaît-il le compte pour pusher ?**
  - Le pipeline utilise :
    ```groovy
    withDockerRegistry(credentialsId: 'c9b058e5-bfe6-41f8-9b5d-dc0b0d2955ac', toolName: 'docker')
    ```
    - **`credentialsId`** : Identifie les informations d'authentification Docker dans Jenkins.
    - Ces informations (nom d'utilisateur et mot de passe Docker Hub) sont configurées dans Jenkins via **Manage Jenkins > Manage Credentials**.
  - Exemple de commande :
    ```bash
    docker push Raslen/shopping-cart:latest
    ```
    Cela pousse l'image dans le compte Docker Hub Raslen.

---

## **Comment accéder à un conteneur Docker ?**

Pour accéder à un conteneur Docker en cours d’exécution et explorer son système de fichiers ou exécuter des commandes :

### **Commande :**
```bash
docker exec -it <nom_du_conteneur> /bin/sh
```

### **Étape par étape :**

1. **Vérifier le nom ou l’ID du conteneur :**
   - Liste tous les conteneurs actifs :
     ```bash
     docker ps
     ```
   - Résultat typique :
     ```
     CONTAINER ID   IMAGE                       COMMAND                  STATUS          PORTS                     NAMES
     abc123def456   Raslen/shopping-cart       "java -jar app.jar"     Up 10 minutes   0.0.0.0:8070->8070/tcp   shopping
     ```
     Ici, le nom du conteneur est **`shopping`**.

2. **Se connecter au conteneur :**
   - Utilise la commande suivante :
     ```bash
     docker exec -it shopping /bin/sh
     ```
   - **`-it`** : Donne un accès interactif (terminal).
   - **`/bin/sh`** : Lance un shell léger dans le conteneur.

3. **Explorer le conteneur :**
   - Une fois à l’intérieur, tu peux naviguer avec des commandes comme :
     ```bash
     cd /usr/src/app
     ls
     ```
     Cela te permettra de voir le fichier **`app.jar`**.

4. **Quitter le conteneur :**
   - Tape simplement :
     ```bash
     exit
     ```

### **Résumé :**
- **`docker exec -it <nom_du_conteneur> /bin/sh`** te permet d'accéder à l'intérieur d'un conteneur.
- Une fois connecté, tu peux naviguer, vérifier les fichiers ou résoudre les problèmes.

---

## **Réel Scénario : Développement et déploiement d’une application Web avec Docker**

1. **Environnement de développement :**

   - Les développeurs configurent leur environnement local en utilisant Docker.
   - Avec Docker Compose, ils définissent les services nécessaires (serveur web, base de données, cache, etc.).
   - Les conteneurs assurent des environnements isolés et cohérents.

2. **Intégration continue (CI) :**

   - Utilisation d’un pipeline CI/CD pour tester et déployer automatiquement.
   - Docker est utilisé pour créer des environnements de build reproductibles.
   - Les images Docker sont taggées avec un identifiant unique (commit hash, numéro de build, etc.).

3. **Environnement de test :**

   - Docker facilite la création et la suppression rapide des environnements de test.
   - Le pipeline CI peut exécuter des tests automatisés dans des conteneurs isolés.
   - Différents environnements de test (staging, intégration) peuvent être définis via Docker Compose.

4. **Déploiement :**

   - Les images Docker validées sont poussées dans un registre (Docker Hub).
   - Les environnements de production utilisent Docker pour gérer les conteneurs.
   - Les outils comme Docker Swarm ou Kubernetes assurent l'orchestration des conteneurs, leur mise à l’échelle et leur haute disponibilité.

---

## **Commandes Docker Principales**

### **1. Construire une image**

```bash
docker build -t <nom_image> <chemin_dockerfile>
```

- **Exemple :

