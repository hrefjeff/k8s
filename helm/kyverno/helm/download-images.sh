#!/bin/bash

# Save the list of unique Kyverno images into a variable
IMAGES=$(kubectl get pods -n kyverno -o jsonpath="{.items[*].spec.containers[*].image}" | tr ' ' '\n' | sort | uniq)

# Loop through the image list, pull them and save to tar
for image in $IMAGES; do
    # Pull the image
    docker pull $image

    # Replace / and : with underscores to make a valid filename
    image_name=$(echo $image | tr '/:' '_')

    # Save the image to a tar file with the sanitized name
    docker save $image -o ${image_name}.tar
done
