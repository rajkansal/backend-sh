#!/bin/bash
set -e

APP_NAME="backend"
IMAGE_NAME="backend-app"
TAG="latest"
CONTAINER_NAME="backend-container"
PORT="8080"

echo "🚀 Starting Backend Deployment..."

echo "🐳 Building Docker image..."
docker build -t $IMAGE_NAME:$TAG .

echo "🧹 Removing old container if exists..."
docker rm -f $CONTAINER_NAME || true

echo "▶️ Running new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:8080 \
  $IMAGE_NAME:$TAG

echo "✅ Backend deployed successfully!"
