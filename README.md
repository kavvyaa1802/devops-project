# DevOps CI/CD Pipeline — Final Year Project

**Author:** Kavya Sri Nallani  
**Project Type:** DevOps Automation — CI/CD Pipeline  
**Status:** ✅ Live & Fully Automated

---

## 🌐 Live URLs

| Service | URL | Purpose |
|---------|-----|---------|
| 🌐 Application | http://100.49.158.149:8081/demo-webapp/ | Live deployed app |
| ⚙️ Jenkins | http://100.49.158.149:8080 | CI/CD pipeline dashboard |
| 🔍 SonarQube | http://100.49.158.149:9000 | Code quality dashboard |
| 📦 GitHub | https://github.com/kavvyaa1802/devops-project | Source code |

---

## 📋 Project Overview

This project implements a complete **CI/CD (Continuous Integration and Continuous Deployment)** pipeline using industry-standard DevOps tools hosted on **AWS EC2**.

Every code change pushed to GitHub **automatically triggers** a Jenkins pipeline that:

1. Pulls the latest code from GitHub
2. Compiles and packages the Java web application as a WAR file
3. Runs 19 unit tests with JaCoCo coverage reporting (54%+)
4. Performs static code analysis via SonarQube
5. Enforces quality gates — blocks deployment if code quality drops
6. Deploys the WAR file to Apache Tomcat automatically
7. Runs a smoke test to confirm the app is live

**Zero manual intervention required after a code push.**

---

## 🛠️ Technology Stack

| Tool | Version | Purpose |
|------|---------|---------|
| AWS EC2 | t2.medium · Ubuntu 26.04 | Cloud infrastructure |
| GitHub | - | Source code management + webhooks |
| Jenkins | 2.555+ | CI/CD automation server |
| Apache Maven | 3.9.12 | Build tool + dependency management |
| JUnit | 4.13.2 | Unit testing framework |
| JaCoCo | 0.8.11 | Code coverage reporting (54%+) |
| SonarQube | 10.6 Community Edition | Code quality + security analysis |
| Apache Tomcat | 10.1.56 | Java servlet container (Jakarta EE) |
| Java | OpenJDK 21 | Runtime environment |

---

## ⚙️ Pipeline Architecture

```
Developer pushes code
        │
        ▼
   GitHub Repository
        │
        │ Webhook (automatic trigger)
        ▼
   Jenkins Pipeline
        │
        ├─── Stage 1: Checkout
        │         Pull latest code from GitHub
        │
        ├─── Stage 2: Build
        │         mvn clean package → WAR file
        │         Build info written into app (build number, timestamp)
        │
        ├─── Stage 3: Test & Coverage
        │         19 unit tests (JUnit 4)
        │         JaCoCo coverage report generated (54%+)
        │
        ├─── Stage 4: SonarQube Analysis
        │         Static code analysis
        │         Bug detection, code smells, security hotspots
        │
        ├─── Stage 5: Quality Gate
        │         Coverage ≥ 50% ✅
        │         New Issues = 0 ✅
        │         Duplications ≤ 3% ✅
        │         FAIL → Pipeline stops, no deployment
        │
        ├─── Stage 6: Deploy to Tomcat
        │         WAR deployed via Tomcat Manager REST API
        │
        └─── Stage 7: Smoke Test
                  HTTP 200 check on live URL
                  Confirms app is running after deploy
        │
        ▼
   Live Application
   http://100.49.158.149:8081/demo-webapp/
```

---

## 📁 Project Structure

```
demo-webapp/
├── Jenkinsfile                          # Pipeline definition (7 stages)
├── pom.xml                              # Maven build config + JaCoCo plugin
├── README.md                            # This file
└── src/
    ├── main/
    │   ├── java/com/example/
    │   │   ├── HelloServlet.java        # Main servlet → /hello endpoint
    │   │   └── PipelineInfo.java        # Utility class (version, stack info)
    │   └── webapp/
    │       ├── index.jsp                # Landing page (Bootstrap 5 dark UI)
    │       ├── about.jsp                # Project info + tech stack page
    │       └── WEB-INF/
    └── test/
        └── java/com/example/
            ├── AppTest.java             # 8 tests for HelloServlet
            └── PipelineInfoTest.java    # 11 tests for PipelineInfo
```

---

## 📊 Quality Metrics

| Metric | Value | Threshold |
|--------|-------|-----------|
| Unit Tests | 19 passing | - |
| Code Coverage | 54%+ | ≥ 50% |
| New Issues | 0 | = 0 |
| Duplications | 0.0% | ≤ 3% |
| Quality Gate | ✅ PASSED | - |

---

## 🔐 Security Practices

- All credentials (SonarQube token, Tomcat password, GitHub PAT) stored in **Jenkins Credentials Store** — never hardcoded in pipeline or visible on GitHub
- External CDN resources use **SRI integrity hashes** (Bootstrap CSS/JS)
- External links use `rel="noopener noreferrer"` to prevent tab-napping attacks
- Servlet exception handling uses `Logger` — prevents sensitive stack trace exposure
- `isCommitted()` check before response — prevents `IllegalStateException`
- Single quotes in shell steps — prevents Groovy credential interpolation

---

## 🚀 How to Trigger the Pipeline

Push any code change to the `main` branch:

```bash
git add .
git commit -m "your message"
git push origin main
```

Jenkins detects the push via GitHub webhook and runs the full 7-stage pipeline automatically within seconds. The app is live within 3-4 minutes of the push.

---

## 🏗️ Infrastructure

All services run on a single **AWS EC2 t2.medium** instance (Ubuntu 26.04 LTS):

| Service | Port | Install Path |
|---------|------|-------------|
| Jenkins | 8080 | `/var/lib/jenkins` |
| Apache Tomcat | 8081 | `/opt/tomcat/apache-tomcat-10.1.56` |
| SonarQube | 9000 | `/opt/sonarqube` |

All three services are configured as **systemd services** and auto-start on instance reboot.

**Disk:** 25GB EBS volume · **RAM:** 3.8GB + 2GB swap

---

## 📝 Jenkins Pipeline Features

- `timestamps()` — every log line shows exact execution time
- `timeout(20 min)` — auto-kills hung builds
- `disableConcurrentBuilds()` — prevents parallel pipeline conflicts
- `buildDiscarder(10)` — keeps only last 10 builds to save disk
- `cleanWs()` — workspace cleanup after every build
- Quality Gate check via SonarQube REST API
- Smoke test confirms live deployment after every release
- Build number + timestamp written into the deployed app on every build

---

## 👩‍💻 Author

**Kavya Sri Nallani**  
Final Year DevOps Project  
GitHub: [@kavvyaa1802](https://github.com/kavvyaa1802)

---

*Built with ❤️ using Jenkins · Maven · SonarQube · Apache Tomcat · AWS EC2 · GitHub*
