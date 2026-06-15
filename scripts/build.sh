#!/bin/bash
# Build the project with Maven

echo "Building Demo project..."
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo "✓ Build successful!"
    echo "JAR file: target/demo.jar"
else
    echo "✗ Build failed!"
    exit 1
fi

