#!/bin/bash
set -euo pipefail
echo "Installing dependencies"
apt-get install -y git


echo "Cloning the repo"
cd /

cd /2526-dotnet-template

echo "Building Docker image"
docker build -t rise-server -f /2526-dotnet-template/deploy/Dockerfile .

echo "Starting Docker container"
docker run -d \
    --name rise-server \
    -p 5001:5001 \
    rise-server

echo "Application started on port 5001"
