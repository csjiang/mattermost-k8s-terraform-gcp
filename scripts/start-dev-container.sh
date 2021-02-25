#!/usr/bin/env bash

export IMAGE_TAG='mattermost-dev:latest'

cd .devcontainer

docker build -t $IMAGE_TAG .
 
cd ..

docker run -it --rm -v $PWD:/app -v ~/.config/gcloud:/mattermost-dev/.config/gcloud -w /app $IMAGE_TAG