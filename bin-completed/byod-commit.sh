#!/usr/bin/env bash
# Usage byod-commit.sh <container> <image>

conName=$1
imageName=$2

conDir=/var/byod/containers/$conName
conFs=$(readlink $conDir/fs)

imageDir=/var/byod/images/$imageName
imageFs=/var/byod/btrfs/$imageName

btrfs subvolume snapshot $conFs $imageFs
mkdir -p $imageDir
ln -s $imageFs $imageDir/fs
echo "Image $imageName created from container $conName" 
