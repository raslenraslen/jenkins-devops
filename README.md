

sudo apt update -y
sudo apt install openjdk-11-jre -y

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y 
sudo apt-get install jenkins -y

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# How to Fix Jenkins Not Starting Due to Java Version

If Jenkins fails to start and the logs show an error about the Java version being too old, follow these steps to resolve the issue:

## 1. Install Java 17 or a Newer Version
Jenkins requires Java 17 or later. Install it using the following commands:
```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
```

## 2. Set Java 17 as the Default Version
After installing Java 17, configure it as the default Java version:
```bash
sudo update-alternatives --config java
```
Select the option corresponding to Java 17 in the list displayed.

## 3. Verify the Installed Java Version
Ensure that Java 17 or a newer version is correctly set:
```bash
java -version
```
The output should show a Java version of 17 or higher.

## 4. Restart Jenkins
Restart the Jenkins service to apply the changes:
```bash
sudo systemctl restart jenkins
```
Check the service status:
```bash
sudo systemctl status jenkins
```

## 5. Access Jenkins in Your Browser
Open Jenkins in your browser at:
```
http://localhost:8080
```

## Notes
- Always ensure your Java version matches Jenkins’ requirements.
- If issues persist, check Jenkins logs for additional errors:
```bash
sudo journalctl -u jenkins.service -n 50
```

