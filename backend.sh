#!/bin/bash
set -e

echo "🚀 Starting Backend Deployment (DEV)"

WORKSPACE=$(pwd)
LOGFILE="$WORKSPACE/deployment.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

log "Using workspace: $WORKSPACE"

IMAGE_NAME="backend:dev"
CONTAINER_NAME="backend-dev"
PORT=5000

log "🐳 Building Docker image..."
docker build -t $IMAGE_NAME .

log "🛑 Removing old container if exists..."
docker rm -f $CONTAINER_NAME || true

log "▶ Starting new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:5000 \
  $IMAGE_NAME

log "✅ DEV Deployment completed successfully"
