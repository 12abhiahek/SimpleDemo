# CI/CD Pipeline Documentation

## Overview
This project uses GitHub Actions for continuous integration and continuous deployment. The pipeline includes automated building, testing, Docker image creation, code quality analysis, and deployment workflows.

## Workflows

### 1. Build and Test (`build-and-test.yml`)
**Triggers:** Push to `main` or `develop` branches, and pull requests

**Steps:**
- Sets up JDK 17
- Builds the project with Maven
- Runs unit tests
- Uploads test results and JAR artifacts

**Run Time:** ~2-3 minutes

### 2. Docker Build and Push (`docker-build-and-push.yml`)
**Triggers:** Push to `main` branch and version tags (v*)

**Steps:**
- Builds the Maven project
- Sets up Docker Buildx
- Logs into GitHub Container Registry (GHCR)
- Builds and pushes Docker image with automatic tagging
- Uses GitHub Actions cache for faster builds

**Docker Tags Generated:**
- `ghcr.io/{owner}/{repo}:main` (for main branch)
- `ghcr.io/{owner}/{repo}:v1.0.0` (for version tags)
- `ghcr.io/{owner}/{repo}:sha-{commit-hash}` (for commits)

### 3. CodeQL Analysis (`codeql-analysis.yml`)
**Triggers:** Push to `main` or `develop`, pull requests, and weekly schedule

**Steps:**
- Initializes CodeQL for security analysis
- Builds the Java project
- Performs code quality and security scanning
- Reports findings to GitHub Security tab

### 4. Deploy to Staging (`deploy-to-staging.yml`)
**Triggers:** Push to `develop` branch or manual workflow_dispatch

**Steps:**
- Builds the Maven project
- Generates a staging docker-compose configuration
- Provides deployment instructions

**Manual Deployment Steps:**
1. SSH to your staging server
2. Pull the latest code
3. Run: `docker-compose -f docker-compose.staging.yml up -d`
4. Monitor: `docker-compose logs -f`

### 5. Release (`release.yml`)
**Triggers:** Push of version tags (v*)

**Steps:**
- Builds the Maven project
- Creates a GitHub Release with the JAR artifact
- Builds and pushes Docker image with release tags
- Auto-generates release notes from commits

## Setup Instructions

### Prerequisites
- GitHub repository with push access
- Docker installed (for local testing)
- Java 17 installed (for local development)
- Maven 3.9+ installed

### Initial Setup

1. **Enable GitHub Actions**
   - Go to your repository Settings → Actions → General
   - Ensure "Allow all actions and reusable workflows" is selected

2. **Configure Docker Registry Authentication**
   - GitHub automatically provides `GITHUB_TOKEN` for GHCR
   - No additional secrets needed for basic setup

3. **Optional: Add Custom Secrets**
   - Go to Settings → Secrets and variables → Actions
   - Add any custom secrets (e.g., `DOCKER_HUB_USERNAME`, deployment credentials)

### Local Testing

Test the CI/CD pipeline locally before pushing:

```bash
# Build and test
mvn clean package

# Build Docker image locally
docker build -t demo:latest .

# Test with docker-compose
docker-compose up -d

# Check logs
docker-compose logs -f nginx
```

## Branch Strategy

- **`main` branch:** Production-ready code
  - Triggers: Build & Test, Docker Build, CodeQL Analysis
  - Requires: passing tests, code review

- **`develop` branch:** Development integration branch
  - Triggers: Build & Test, CodeQL Analysis, Deploy to Staging
  - Receives: feature branches via pull requests

- **Feature branches:** Feature development (`feature/*`, `bugfix/*`, etc.)
  - Triggers: Build & Test, CodeQL Analysis on PR
  - Must pass: all checks before merging to `develop`

## Release Process

1. **Create a release tag:**
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. **Automated Process:**
   - `release.yml` workflow triggers
   - JAR built and uploaded to GitHub Releases
   - Docker image built and pushed to GHCR with version tags
   - Release notes auto-generated

3. **Pull the Release:**
   ```bash
   docker pull ghcr.io/{owner}/{repo}:v1.0.0
   docker run -p 8080:8080 ghcr.io/{owner}/{repo}:v1.0.0
   ```

## Docker Image Details

### Image Name
- **Repository:** `ghcr.io/{github-owner}/{repo-name}`
- **Builds:** Multi-stage Dockerfile for optimized size
- **Base Image:** `eclipse-temurin:17-jre-alpine` (lightweight)
- **Port:** 8080 (Spring Boot default)

### Health Check
- Endpoint: `http://localhost:8080/actuator/health`
- Interval: 30 seconds
- Timeout: 3 seconds
- Retries: 3 attempts

## Monitoring & Troubleshooting

### View Workflow Runs
1. Go to repository → Actions tab
2. Click on workflow name to see all runs
3. Click on a run to see details

### Common Issues

**Workflow fails on Maven build:**
- Check Java version (must be 17)
- Verify `pom.xml` syntax
- Check for dependency issues: `mvn dependency:tree`

**Docker push fails:**
- Verify GitHub Token has `write:packages` permission
- Check repository is public or GHCR access is configured
- Review GitHub Actions logs for specific error

**Tests fail in CI but pass locally:**
- Check environment variables in workflow
- Verify test data/fixtures are included
- Check for hardcoded paths (use relative paths)

## Performance Optimization

Current optimizations:
- Maven dependency caching
- Docker layer caching via GitHub Actions
- Parallel Docker builds
- Alpine Linux base image for smaller footprint

## Cost Considerations

- GitHub Actions: Free tier includes 2,000 minutes/month
- Docker builds: ~2-3 min per build
- Estimate: ~30-40 builds/month fits comfortably in free tier
- GHCR: Free private storage for Actions

## Next Steps

1. Test the workflows by pushing to branches
2. Configure branch protection rules in Settings
3. Set up automated deployments to production
4. Add status badges to README.md
5. Configure notifications for workflow failures

## Support & References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Build Action](https://github.com/docker/build-push-action)
- [Spring Boot with Docker](https://spring.io/guides/gs/spring-boot-docker/)
- [Maven in GitHub Actions](https://github.com/actions/setup-java)

