#!/bin/bash

# Extract the version from the Ruby file
VERSION=$(ruby -r./version.rb -e 'puts DONControlHub::VERSION')

# Build the Docker image with the version tag
docker build -t awkwardsandwich7/don_central_hub:$VERSION .

# Push the image to Docker Hub with the version tag
docker push awkwardsandwich7/don_central_hub:$VERSION

# Optionally tag the image as latest and push it
docker tag awkwardsandwich7/don_central_hub:$VERSION awkwardsandwich7/don_central_hub:latest
docker push awkwardsandwich7/don_central_hub:latest

# Output the version for confirmation
echo "Docker image pushed with version: $VERSION"
