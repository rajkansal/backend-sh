#!/bin/bash

# Define log file path
LOGFILE="/home/ubuntu/dev_ecr/.logs/deployment.log"

# Function to log messages
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOGFILE"
}

# Function to pull latest changes from a Git repository
git_pull() {
    cd "$1" || { log "Error: Directory $1 does not exist."; exit 1; }
    log "Pulling latest changes from $2 in $1 with --ff..."
    if git pull --ff origin "$2"; then
        log "Successfully pulled latest changes from $2 in $1."
    else
        log "Error: Failed to pull changes from $2 in $1."
        exit 1
    fi
}

git_pull "/home/ubuntu/dev_ecr/backend" "development"

# Build Docker image and tag as `dev_latest`
REPO_NAME="backend"
CONTEXT_PATH="/home/ubuntu/dev_ecr/backend"
TAG="dev_latest"

log "Building Docker image $REPO_NAME:$TAG using context $CONTEXT_PATH..."
docker build -t $REPO_NAME:$TAG $CONTEXT_PATH || {
    log "Error: Failed to build Docker image $REPO_NAME:$TAG."
    exit 1
}
log "Docker image $REPO_NAME:$TAG built successfully."

# Restart frontend service with new image
cd /home/ubuntu/gotrust_dev/deployment
log "Stopping backend service..."
docker compose down backend

log "Starting frontend service using latest image..."
docker compose up -d --build backend

# Optional: Clean up unused images
log "Cleaning up unused Docker images..."
docker image prune -a -f

log "Backend Deployment Completed Successfully."
