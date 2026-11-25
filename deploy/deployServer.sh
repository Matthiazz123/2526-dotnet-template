#!/bin/bash
set -euo pipefail

TARGET="${1:?usage: deploy-server.sh user@host}"
export DOCKER_HOST="ssh://$TARGET"     # all docker commands run on dmz010

echo "Building image on $TARGET"
docker build -t rise-server -f ./deploy/Dockerfile .

docker rm -f rise-server 2>/dev/null || true

echo "Starting container"
docker run -d --name rise-server --restart unless-stopped \
  -p 127.0.0.1:5001:5001 \
  -e ASPNETCORE_ENVIRONMENT=Production \
  -e "ConnectionStrings__DatabaseConnection=${DB_CONNECTION:?DB_CONNECTION not set}" \
  rise-server
