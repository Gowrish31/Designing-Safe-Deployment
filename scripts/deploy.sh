#!/bin/bash

set -e

IMAGE="${REGISTRY}/orion-api:${IMAGE_TAG}"

echo "[deploy] Building image: $IMAGE"
docker build -t "$IMAGE" .

echo "[deploy] Pushing to registry..."
docker push "$IMAGE"

echo "[deploy] Updating production service..."
gcloud run services update orion-api \
  --image "$IMAGE" \
  --region us-central1 \
  --platform managed

echo "[deploy] Done."
