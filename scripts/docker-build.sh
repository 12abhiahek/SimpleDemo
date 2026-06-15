#!/bin/bash
# Build Docker image locally

echo "Building Docker image..."
docker build -t demo:latest .

if [ $? -eq 0 ]; then
    echo "✓ Docker image built successfully!"
    echo "Image: demo:latest"
    docker image inspect demo:latest | grep -E "Created|Size"
else
    echo "✗ Docker build failed!"
    exit 1
fi

