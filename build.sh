#!/bin/bash
set -euo pipefail

REPOSITORY='microproxy'
TAG='1.0.4'

REGISTRY="us-east1-docker.pkg.dev/astral-net-346914/kredit"

docker build . -t $REGISTRY/$REPOSITORY:$TAG
docker push $REGISTRY/$REPOSITORY:$TAG
