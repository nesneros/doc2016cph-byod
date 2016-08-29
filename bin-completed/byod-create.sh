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
btrfs subvolume snapshot $imageFs $conFs
ln -s $conFs $conDir/fs

# Add google dns to container
echo 'nameserver 8.8.8.8' > $conFs/etc/resolv.conf

echo "Container $conName created"
