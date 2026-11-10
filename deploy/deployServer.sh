#!/bin/bash
set -euo pipefail

# Stop and remove the old container if it exists (ignore errors if it doesn't)
docker stop riseapp || true
docker rm riseapp || true

echo "Building Docker image"
docker build -t rise-server -f ./deploy/Dockerfile .

echo "Starting Docker container"
docker run -d \
    --name rise-server \
    -p 5001:5001 \
    rise-server

echo "Application started on port 5001"
