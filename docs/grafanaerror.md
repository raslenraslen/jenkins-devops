# Docker, Grafana, and Prometheus Troubleshooting Guide

## **Introduction**
Ce fichier documente les erreurs courantes, solutions et explications des outils Docker, Grafana et Prometheus, pour que vous puissiez les réutiliser et éviter les erreurs futures.

---

## **Docker Compose Basics**
Docker Compose est un outil permettant de définir et de gérer plusieurs conteneurs en une seule commande à l’aide d’un fichier `docker-compose.yml`.

- **Démarrer les conteneurs :**
  ```bash
  docker-compose up -d
  ```

- **Reconstruire les images et démarrer les conteneurs :**
  ```bash
  docker-compose up --build -d
  ```

- **Arrêter les conteneurs :**
  ```bash
  docker-compose down
  ```

- **Nettoyer les volumes et conteneurs orphelins :**
  ```bash
  docker-compose down --volumes --remove-orphans
  ```

---

## **Erreur : Port Déjà Utilisé**
**Message d’erreur :**
```
Bind for 0.0.0.0:<PORT> failed: port is already allocated
```

### **Solution :**
1. **Identifier le processus utilisant le port :**
   ```bash
   sudo lsof -i :<PORT>
   ```
   Exemple :
   ```bash
   sudo lsof -i :8081
   ```

2. **Arrêter le processus :**
   - Avec Docker :
     ```bash
     docker ps
     docker stop <container_id>
     docker rm <container_id>
     ```
   - Avec un autre service :
     ```bash
     sudo kill -9 <PID>
     ```

3. **Changer les ports dans `docker-compose.yml` :**
   Si vous ne voulez pas libérer le port, modifiez le fichier YAML. Exemple :
   ```yaml
   ports:
     - "9091:9090" # Modifier le port hôte
   ```

---

## **Erreur : `ContainerConfig`**
**Message d’erreur :**
```
ERROR: 'ContainerConfig'
```

### **Solution :**
1. **Supprimer tous les conteneurs et volumes inutilisés :**
   ```bash
   docker-compose down --volumes --remove-orphans
   docker system prune -a --volumes -f
   ```

2. **Reconstruire et relancer les conteneurs :**
   ```bash
   docker-compose up --build -d
   ```

3. **Vérifier les logs des conteneurs :**
   ```bash
   docker-compose logs
   ```
   Regardez les journaux pour des informations détaillées.

---

## **Nettoyer Docker**
Pour résoudre les problèmes liés à des configurations ou des images obsolètes :

1. **Supprimer les conteneurs non utilisés :**
   ```bash
   docker container prune
   ```

2. **Supprimer les volumes non utilisés :**
   ```bash
   docker volume prune
   ```

3. **Supprimer les images non utilisées :**
   ```bash
   docker image prune -a
   ```

4. **Supprimer les réseaux non utilisés :**
   ```bash
   docker network prune
   ```

---

## **Débogage Docker Compose**
- **Vérifier le fichier `docker-compose.yml` :**
  ```bash
  docker-compose config
  ```
  Cette commande valide la syntaxe et identifie les erreurs.

- **Lister les conteneurs Docker actifs :**
  ```bash
  docker ps
  ```

- **Vérifier les journaux d’un conteneur :**
  ```bash
  docker logs <container_id>
  ```

---

## **Configuration de Grafana et Prometheus avec Docker Compose**
### **Fichier `docker-compose.yml` :**
Exemple avec des ports ajustés pour éviter les conflits :
```yaml
version: "3"

networks:
  grafana:

volumes:
  app_data: {}

services:
  prometheus:
    image: prom/prometheus:v2.49.0
    volumes:
      - ./prometheus/:/etc/prometheus/
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"
      - "--storage.tsdb.path=/prometheus"
    ports:
      - 9091:9090 # Port modifié
    networks:
      - grafana

  loki:
    image: grafana/loki:2.9.0
    ports:
      - 3101:3100 # Port modifié
    networks:
      - grafana

  grafana:
    image: grafana/grafana:11.3.0
    ports:
      - 3102:3000 # Port modifié
    networks:
      - grafana
    environment:
      - "GF_DEFAULT_APP_MODE=development"
      - "GF_LOG_LEVEL=debug"
      - GF_AUTH_ANONYMOUS_ENABLED=true
    volumes:
      - ./grafana/provisioning/datasources:/etc/grafana/provisioning/datasources

  app:
    build: ./app
    ports:
      - 9081:80 # Port modifié
    networks:
      - grafana

  db:
    image: grafana/tns-db:latest
    ports:
      - 9082:80 # Port modifié
    networks:
      - grafana
```

---

## **Résumé des commandes importantes**
1. **Démarrer les conteneurs :**
   ```bash
   docker-compose up -d
   ```

2. **Arrêter les conteneurs :**
   ```bash
   docker-compose down
   ```

3. **Nettoyer Docker :**
   ```bash
   docker system prune -a --volumes -f
   ```

4. **Vérifier les ports :**
   ```bash
   sudo lsof -i :<PORT>
   ```

5. **Reconstruire les conteneurs :**
   ```bash
   docker-compose up --build -d
   ```

---

**Avec ce guide, tu pourras éviter les erreurs courantes et mieux comprendre les concepts de Docker, Grafana et Prometheus !** 😊

