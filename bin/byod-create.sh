#!/usr/bin/env bash

# Create a container from image
# Usage: byod-create <imageName> <containerName>
imageName=$1
conName=$2
imageDir=/var/byod/images/$imageName
conDir=/var/byod/containers/$conName
mkdir $conDir

imageFs=$(readlink $imageDir/fs)
conFs=/var/byod/btrfs/con$conName 

# TODO create a snapshot of image fs for the container and symlink it from fs in conDir

# Add google dns to container
echo 'nameserver 8.8.8.8' > $conFs/etc/resolv.conf

echo "Container $conName created"
