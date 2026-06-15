# CI/CD Pipeline - Getting Started Guide

Welcome! Your project now has a complete CI/CD pipeline set up. This guide will help you get started.

## 📋 What Was Created

Your project now includes:

### GitHub Actions Workflows (5 total)
- ✅ **Build and Test** - Runs on every push and PR
- ✅ **Docker Build and Push** - Builds and pushes Docker images
- ✅ **CodeQL Analysis** - Security scanning
- ✅ **Deploy to Staging** - Automated staging deployment
- ✅ **Release** - Creates releases on version tags

### Configuration Files
- ✅ **Dockerfile** - Multi-stage Docker build
- ✅ **docker-compose.yml** - Enhanced with health checks
- ✅ **.dockerignore** - Docker ignore patterns
- ✅ **pom.xml** - Updated with Actuator dependency

### Helper Scripts (Windows & Linux)
- ✅ **scripts/build.bat/sh** - Build locally
- ✅ **scripts/test.bat/sh** - Run tests
- ✅ **scripts/docker-build.bat/sh** - Build Docker image
- ✅ **scripts/docker-run.bat/sh** - Run with Docker Compose

### Documentation
- ✅ **CI-CD-PIPELINE.md** - Detailed workflow documentation
- ✅ **CI-CD-README.md** - Project-level CI/CD guide
- ✅ **CI-CD-GETTING-STARTED.md** - This file

## 🚀 Quick Start (3 Steps)

### Step 1: Prepare Your Repository
```powershell
# Initialize git if needed
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit with CI/CD pipeline"
```

### Step 2: Push to GitHub
```powershell
# Add remote (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/Demo.git

# Push to main branch
git branch -M main
git push -u origin main
```

### Step 3: Verify GitHub Actions
1. Go to your GitHub repository
2. Click on the **Actions** tab
3. You should see "Build and Test" workflow running
4. Wait for it to complete (green checkmark = success)

## 🧪 Test the Workflows

### Test 1: Build Workflow (Automatic)
Your push already triggered this. Check the Actions tab to see it run.

### Test 2: Docker Build Workflow
Push any change to the `main` branch:
```powershell
# Make a small change
echo "# Updated" >> README.md

git add README.md
git commit -m "Test docker build"
git push origin main
```

### Test 3: Release Workflow
Create a version tag:
```powershell
# Create a release tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

This triggers the release workflow which:
- Creates a GitHub Release
- Pushes Docker image to GHCR with version tag
- Uploads JAR file as release artifact

## 💻 Local Development (Windows)

All scripts are available as `.bat` files for Windows:

```powershell
# Build the project
.\scripts\build.bat

# Run tests
.\scripts\test.bat

# Build Docker image
.\scripts\docker-build.bat

# Start containers with docker-compose
.\scripts\docker-run.bat

# View logs
docker-compose logs -f

# Stop containers
.\scripts\docker-run.bat down
```

## 🐳 Docker Setup

The Docker setup includes:
- **3 App Instances** running on ports 8081-8083
- **Nginx Load Balancer** on port 80
- **Health Checks** on all containers
- **Automatic Restart** on failure

### Run Locally
```powershell
.\scripts\docker-run.bat
```

Then access:
- Single app: http://localhost:8081
- Through load balancer: http://localhost:80
- Health check: http://localhost:8081/actuator/health

## 📦 Docker Images

After the first release, Docker images will be available at:
```
ghcr.io/YOUR_USERNAME/Demo:v1.0.0
ghcr.io/YOUR_USERNAME/Demo:latest
```

Pull and run:
```bash
docker pull ghcr.io/YOUR_USERNAME/Demo:v1.0.0
docker run -p 8080:8080 ghcr.io/YOUR_USERNAME/Demo:v1.0.0
```

## 🔐 GitHub Secrets (Optional)

For advanced features, add secrets in GitHub Settings:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Add custom secrets if needed (see `.github/SECRETS.md`)

Default setup uses GitHub's automatic `GITHUB_TOKEN` - no additional config needed.

## 📊 Monitoring Workflows

### View Workflow Status
1. Go to GitHub → **Actions** tab
2. Click on a workflow to see details
3. Click on a run to see logs

### Add Status Badges to README
```markdown
![Build Status](https://github.com/YOUR_USERNAME/Demo/workflows/Build%20and%20Test/badge.svg)
![Release](https://github.com/YOUR_USERNAME/Demo/workflows/Release/badge.svg)
```

## 🌳 Branch Strategy

### `main` branch
- **Purpose:** Production-ready code
- **Workflows:** Build & Test, Docker Build, CodeQL
- **Requirements:** Pull request with review

### `develop` branch  
- **Purpose:** Integration branch
- **Workflows:** Build & Test, CodeQL, Staging Deploy
- **Source:** Feature branches merge here

### Feature branches
- **Naming:** `feature/your-feature`, `bugfix/your-fix`
- **Source:** Branch from `develop`
- **Merge:** Via pull request to `develop`

## 🔄 Typical Workflow

1. **Create feature branch**
   ```powershell
   git checkout -b feature/my-feature
   ```

2. **Make changes and test locally**
   ```powershell
   .\scripts\build.bat
   .\scripts\test.bat
   .\scripts\docker-run.bat
   ```

3. **Commit and push**
   ```powershell
   git commit -am "Add my feature"
   git push origin feature/my-feature
   ```

4. **Create pull request on GitHub**
   - Go to repository
   - Click "Create Pull Request"
   - Wait for checks to pass (Build & Test, CodeQL)

5. **Merge to develop**
   ```powershell
   git checkout develop
   git pull origin develop
   git merge --no-ff feature/my-feature
   git push origin develop
   ```

6. **Merge to main for release**
   ```powershell
   git checkout main
   git pull origin main
   git merge --no-ff develop
   git push origin main
   ```

7. **Create release tag**
   ```powershell
   git tag -a v1.0.1 -m "Version 1.0.1"
   git push origin v1.0.1
   ```

## ⚙️ Deployment

### Staging Deployment
Automatically triggered on `develop` push:
```powershell
git push origin develop
# Workflow runs automatically
# Check Actions tab for status
```

### Production Deployment
Create a release tag:
```powershell
git tag -a v1.0.0 -m "Production release"
git push origin v1.0.0
# Workflow creates release and pushes Docker image
```

## 🐛 Troubleshooting

### Workflow fails to start
- ✓ Check GitHub Actions is enabled (Settings → Actions)
- ✓ Verify files are pushed to GitHub
- ✓ Check `.github/workflows/*.yml` files exist

### Build fails
- ✓ Run locally: `.\scripts\build.bat`
- ✓ Check Java version: `java -version`
- ✓ Check Maven: `mvn -v`
- ✓ Review workflow logs in Actions tab

### Docker build fails
- ✓ Run locally: `.\scripts\docker-build.bat`
- ✓ Check Docker running: `docker ps`
- ✓ Review Dockerfile for errors
- ✓ Check logs in Actions tab

### Tests fail
- ✓ Run locally: `.\scripts\test.bat`
- ✓ Check test data exists
- ✓ Verify all dependencies installed
- ✓ Check for hardcoded paths

## 📚 Documentation Files

Read these for more details:
1. **CI-CD-PIPELINE.md** - Detailed workflow documentation
2. **CI-CD-README.md** - Project CI/CD overview
3. **.github/SECRETS.md** - Secrets and security guide

## ✨ Key Features

✅ Automated build and test on every push  
✅ Automatic Docker image creation  
✅ Security scanning with CodeQL  
✅ Automated staging deployment  
✅ Release management with versioning  
✅ GitHub Container Registry (GHCR) integration  
✅ Health checks on containers  
✅ Load balancing with Nginx  
✅ Multi-stage Docker build for optimization  
✅ Windows and Linux script support  

## 🎯 Next Steps

1. ✅ Push your code to GitHub
2. ✅ Watch the Build workflow complete
3. ✅ Make a change and test the workflow
4. ✅ Create a release tag to test release workflow
5. ✅ Pull Docker image and run it: `docker pull ghcr.io/...`
6. ✅ Set up branch protection rules (optional)
7. ✅ Add status badges to README

## 💡 Tips

- **Faster builds:** Docker and Maven layers are cached
- **Better security:** Enable branch protection + required checks
- **Better monitoring:** Set up GitHub notifications
- **Better testing:** Add more test cases before release
- **Better docs:** Update README with your project info

## 🆘 Need Help?

1. Check the detailed documentation files
2. Review workflow logs in GitHub Actions tab
3. Run scripts locally to debug issues
4. Check prerequisite installations (Java, Maven, Docker)

## 📝 Summary

Your project now has:
- ✅ 5 automated GitHub Actions workflows
- ✅ Docker containerization with Nginx load balancing
- ✅ Staging and production deployment capability
- ✅ Security scanning (CodeQL)
- ✅ Automated testing and building
- ✅ Release management
- ✅ Complete documentation

**You're all set! Push to GitHub and watch the CI/CD pipeline in action.** 🚀

