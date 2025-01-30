#!/bin/sh

# Exit immediately if a simple command exits with a nonzero exit value
set -e

docker build -f docker/dockerfile -t terraform-own-module .
docker-compose -f docker/docker-compose.yml run --rm mainservice
