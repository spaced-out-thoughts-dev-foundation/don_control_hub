#!/bin/bash

# Pull the latest image
docker pull awkwardsandwich7/don_central_hub:latest

# Get the image ID of the running container
RUNNING_IMAGE_ID=$(docker inspect --format='{{.Image}}' don_central_hub | cut -d':' -f2 | cut -c1-12)

# Get the list of all images with their tags and IDs
ALL_IMAGES=$(docker images --format '{{.Tag}} {{.ID}}' awkwardsandwich7/don_central_hub | sort -r)

# Initialize the counter
counter=0
found=false

# Iterate through the list of images
while read -r line; do
    tag=$(echo $line | awk '{print $1}')
    image_id=$(echo $line | awk '{print $2}')

    # Check if this is the running image
    if [ "$image_id" == "$RUNNING_IMAGE_ID" ]; then
        found=true
        break
    fi
    
    # Increment the counter for each version found before the running image
    counter=$((counter + 1))
done <<< "$ALL_IMAGES"

if [ "$found" == true ]; then
    echo "The running container is $counter versions behind the latest."
    if [ "$counter" -eq 0 ]; then
        echo "The running container is up-to-date."
    else
        echo "The running container's image is $RUNNING_IMAGE_ID."
        make stop-and-remove
        make run
    fi
else
    echo "The running container's image was not found in the local image cache."
fi
