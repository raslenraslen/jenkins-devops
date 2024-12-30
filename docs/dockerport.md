# Docker Containers and Ports

This document lists all active Docker containers on the system and the ports they expose for accessibility.

## **Active Docker Containers**

### **1. Loki**
- **Image:** `grafana/loki:2.9.0`
- **Command:** `/usr/bin/loki -config.file=/etc/loki/local-config.yaml`
- **Ports:**
  - Host: `3101` -> Container: `3100`

### **2. Database (DB)**
- **Image:** `grafana/tns-db:latest`
- **Command:** `/db`
- **Ports:**
  - Host: `9082` -> Container: `80`

### **3. Application (App)**
- **Image:** `tutorial-environment_app`
- **Command:** `/bin/sh -c '/app http://localhost:9081'`
- **Ports:**
  - Host: `9081` -> Container: `80`

### **4. Grafana**
- **Image:** `grafana/grafana:11.3.0`
- **Command:** `/run.sh`
- **Ports:**
  - Host: `3102` -> Container: `3000`

### **5. Prometheus**
- **Image:** `prom/prometheus:v2.49.0`
- **Command:** `/bin/prometheus --config.file=/etc/prometheus/prometheus.yml`
- **Ports:**
  - Host: `9091` -> Container: `9090`

### **6. Promtail**
- **Image:** `grafana/promtail:2.0.0`
- **Command:** `/usr/bin/promtail -config.file=/etc/promtail/config.yml`
- **Ports:**
  - **No external ports exposed.**

### **7. Nexus**
- **Image:** `sonatype/nexus3`
- **Command:** `/opt/sonatype/nexus/bin/nexus run`
- **Ports:**
  - Host: `8081` -> Container: `8081`

### **8. SonarQube**
- **Image:** `sonarqube:lts-community`
- **Command:** `/opt/sonarqube/docker/run.sh`
- **Ports:**
  - Host: `9000` -> Container: `9000`

## **Summary Table**

| **Service**      | **Image**                  | **Host Port** | **Container Port** |
|-------------------|----------------------------|---------------|---------------------|
| Loki             | grafana/loki:2.9.0         | 3101          | 3100                |
| Database (DB)    | grafana/tns-db:latest      | 9082          | 80                  |
| Application (App)| tutorial-environment_app   | 9081          | 80                  |
| Grafana          | grafana/grafana:11.3.0     | 3102          | 3000                |
| Prometheus       | prom/prometheus:v2.49.0    | 9091          | 9090                |
| Promtail         | grafana/promtail:2.0.0     | **None**      | **None**            |
| Nexus            | sonatype/nexus3            | 8081          | 8081                |
| SonarQube        | sonarqube:lts-community    | 9000          | 9000                |

---

This file provides a comprehensive overview of all active Docker containers and their corresponding ports for easier accessibility and management.

