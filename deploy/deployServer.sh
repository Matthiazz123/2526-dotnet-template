#!/bin/bash
set -euo pipefail

echo "Building Docker image"
docker build -t rise-server -f ./deploy/Dockerfile .

echo "Starting Docker container"
docker run -d \
    --name rise-server \
    -p 5001:5001 \
    rise-server

echo "Application started on port 5001"
