#!/bin/bash
# Run tests for the project

echo "Running tests for Demo project..."
mvn test

if [ $? -eq 0 ]; then
    echo "✓ All tests passed!"
else
    echo "✗ Some tests failed!"
    exit 1
fi

