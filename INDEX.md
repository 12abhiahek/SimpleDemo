# CI/CD Pipeline - Complete Documentation Index

## 🎯 Start Here

**New to this CI/CD setup?** Start with one of these:

1. **[CI-CD-GETTING-STARTED.md](CI-CD-GETTING-STARTED.md)** ⭐ **START HERE**
   - 3-step quick start
   - Local development guide
   - Windows PowerShell commands
   - Troubleshooting tips

2. **[IMPLEMENTATION-SUMMARY.md](IMPLEMENTATION-SUMMARY.md)**
   - What was created
   - Technical overview
   - Architecture diagram
   - Verification checklist

## 📚 Detailed Documentation

### CI/CD Workflows & Features

- **[CI-CD-PIPELINE.md](CI-CD-PIPELINE.md)**
  - Complete workflow documentation
  - Trigger conditions
  - Step-by-step breakdown
  - Branch strategy
  - Release process
  - Docker details
  - Troubleshooting guide

- **[CI-CD-README.md](CI-CD-README.md)**
  - Project-level overview
  - Available GitHub Actions workflows
  - Setup instructions
  - Local testing procedures
  - Project structure
  - Docker configuration
  - Deployment instructions
  - Monitoring guides

### Security & Configuration

- **[.github/SECRETS.md](.github/SECRETS.md)**
  - Required secrets
  - Optional secrets setup
  - Environment variables
  - Security best practices

## 🛠️ Configuration Files

### GitHub Actions Workflows (`.github/workflows/`)

1. **[.github/workflows/build-and-test.yml](.github/workflows/build-and-test.yml)**
   - Triggers: Push to main/develop, PRs
   - Duration: 2-3 minutes
   - Functions: Build, test, upload artifacts

2. **[.github/workflows/docker-build-and-push.yml](.github/workflows/docker-build-and-push.yml)**
   - Triggers: Push to main, version tags
   - Duration: 3-5 minutes
   - Functions: Build Docker image, push to GHCR
   - Registry: `ghcr.io/{owner}/{repo}`

3. **[.github/workflows/codeql-analysis.yml](.github/workflows/codeql-analysis.yml)**
   - Triggers: Push, PRs, weekly schedule
   - Duration: 5-7 minutes
   - Functions: Security scanning, code quality

4. **[.github/workflows/deploy-to-staging.yml](.github/workflows/deploy-to-staging.yml)**
   - Triggers: Push to develop, manual dispatch
   - Duration: 3 minutes
   - Functions: Build, generate staging config

5. **[.github/workflows/release.yml](.github/workflows/release.yml)**
   - Triggers: Version tags (v*)
   - Duration: 5-8 minutes
   - Functions: Create release, push final Docker image

### Docker Configuration

- **[Dockerfile](Dockerfile)**
  - Multi-stage build (Maven → Alpine JRE)
  - Size: ~200-300MB
  - Port: 8080
  - Health check endpoint

- **[docker-compose.yml](docker-compose.yml)**
  - 3 application instances (ports 8081-8083)
  - Nginx load balancer (port 80)
  - Health checks (30s interval)
  - Automatic restart policy
  - Service dependencies

- **[.dockerignore](.dockerignore)**
  - Docker build optimization
  - Excludes unnecessary files

### Build & Application

- **[pom.xml](pom.xml)**
  - Java 17 target
  - Spring Boot 4.1.0
  - Spring Actuator (for health checks)
  - Maven plugins

- **[src/main/resources/application.yaml](src/main/resources/application.yaml)**
  - Application name: Demo
  - Actuator health endpoint enabled
  - Detailed health information

### Nginx Configuration

- **[nginx.conf](nginx.conf)**
  - Load balancer configuration
  - 3 upstream servers (8081-8083)
  - Proxy headers

## 🚀 Helper Scripts

### Windows (PowerShell / Batch)

- **[scripts/setup.bat](scripts/setup.bat)** - Check prerequisites
- **[scripts/build.bat](scripts/build.bat)** - Build project locally
- **[scripts/test.bat](scripts/test.bat)** - Run tests locally
- **[scripts/docker-build.bat](scripts/docker-build.bat)** - Build Docker image
- **[scripts/docker-run.bat](scripts/docker-run.bat)** - Run with docker-compose

**Usage:**
```powershell
.\scripts\build.bat
.\scripts\test.bat
.\scripts\docker-run.bat
# View logs: docker-compose logs -f
# Stop: .\scripts\docker-run.bat down
```

### Linux/Mac (Bash)

- **[scripts/setup.sh](scripts/setup.sh)** - Check prerequisites
- **[scripts/build.sh](scripts/build.sh)** - Build project locally
- **[scripts/test.sh](scripts/test.sh)** - Run tests locally
- **[scripts/docker-build.sh](scripts/docker-build.sh)** - Build Docker image
- **[scripts/docker-run.sh](scripts/docker-run.sh)** - Run with docker-compose

**Usage:**
```bash
./scripts/build.sh
./scripts/test.sh
./scripts/docker-run.sh
```

## 📊 Quick Reference

### Workflow Triggers

| Trigger | Workflows |
|---------|-----------|
| Push to `main` | Build & Test, Docker Build, CodeQL |
| Push to `develop` | Build & Test, CodeQL, Deploy Staging |
| Pull Request | Build & Test, CodeQL |
| Version Tag (v*) | Release |
| Schedule (weekly) | CodeQL |

### Docker Image Tags

```
ghcr.io/{owner}/{repo}:main          # main branch
ghcr.io/{owner}/{repo}:develop       # develop branch
ghcr.io/{owner}/{repo}:v1.0.0        # version tags
ghcr.io/{owner}/{repo}:sha-{hash}    # commit hash
ghcr.io/{owner}/{repo}:latest        # latest release
```

### Service Access

```
App 1: http://localhost:8081
App 2: http://localhost:8082
App 3: http://localhost:8083
Load Balancer: http://localhost:80
Health Check: http://localhost:8081/actuator/health
```

## 🎯 Common Tasks

### Development
1. [CI-CD-GETTING-STARTED.md](CI-CD-GETTING-STARTED.md) - Local setup
2. [scripts/build.bat](scripts/build.bat) or [scripts/build.sh](scripts/build.sh) - Build code
3. [scripts/test.bat](scripts/test.bat) or [scripts/test.sh](scripts/test.sh) - Run tests
4. [scripts/docker-run.bat](scripts/docker-run.bat) or [scripts/docker-run.sh](scripts/docker-run.sh) - Test with Docker

### Release Process
1. Create version tag: `git tag -a v1.0.0 -m "Version 1.0.0"`
2. Push tag: `git push origin v1.0.0`
3. [CI-CD-PIPELINE.md](CI-CD-PIPELINE.md#release-process) - Release details
4. Pull Docker image: `docker pull ghcr.io/{owner}/{repo}:v1.0.0`

### Troubleshooting
- [CI-CD-GETTING-STARTED.md](CI-CD-GETTING-STARTED.md#-troubleshooting) - Quick fixes
- [CI-CD-PIPELINE.md](CI-CD-PIPELINE.md#troubleshooting--) - Detailed troubleshooting
- Check GitHub Actions logs in repository Actions tab

## 📈 What's Included

✅ **5 GitHub Actions Workflows**  
✅ **Docker Multi-Stage Build**  
✅ **Nginx Load Balancer Setup**  
✅ **Health Check Configuration**  
✅ **CodeQL Security Scanning**  
✅ **Release Management**  
✅ **Staging Deployment**  
✅ **Windows & Linux Helper Scripts**  
✅ **Complete Documentation**  
✅ **Secrets Management Guide**  

## 🔐 Security Notes

- All secrets are GitHub Token-based (no extra config needed)
- CodeQL security scanning enabled automatically
- Docker images pushed to GHCR with authentication
- Read-only volume mounts for configuration
- See [.github/SECRETS.md](.github/SECRETS.md) for security best practices

## 📝 Document Overview

| Document | Purpose | Audience |
|----------|---------|----------|
| **CI-CD-GETTING-STARTED.md** | Begin here | Everyone (start point) |
| **IMPLEMENTATION-SUMMARY.md** | What was done | Project leads, architects |
| **CI-CD-PIPELINE.md** | Detailed workflows | DevOps, power users |
| **CI-CD-README.md** | Project overview | Developers |
| **.github/SECRETS.md** | Security setup | DevOps, admins |

## 🚀 Next Steps

1. **Read:** [CI-CD-GETTING-STARTED.md](CI-CD-GETTING-STARTED.md)
2. **Push:** Code to GitHub
3. **Verify:** Actions tab shows successful workflows
4. **Deploy:** Create release tag when ready
5. **Monitor:** Check GitHub Actions for run status

## 💡 Pro Tips

- **Cache:** Maven and Docker layers are cached for faster builds
- **Parallel:** Workflows run in parallel when possible
- **Badges:** Add status badges from Actions to README
- **Monitoring:** Use GitHub notifications for workflow status
- **Scaling:** Modify replicas in docker-compose.yml as needed

## 📞 Support Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com)
- [Spring Boot Documentation](https://spring.io/guides)
- [Maven Documentation](https://maven.apache.org/guides)
- [Nginx Documentation](https://nginx.org/en/docs)

---

**Last Updated:** June 16, 2026  
**Status:** ✅ Complete and Ready for Use  
**Files Created:** 25+ (workflows, scripts, documentation)  
**Workflows:** 5 active GitHub Actions  
**Documentation:** 5 comprehensive markdown files

