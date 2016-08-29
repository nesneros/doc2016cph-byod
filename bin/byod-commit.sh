#!/usr/bin/env bash
# Usage byod-commit.sh <container> <image>

conName=$1
imageName=$2

conDir=/var/byod/containers/$conName
conFs=$(readlink $conDir/fs)

imageDir=/var/byod/images/$imageName
imageFs=/var/byod/btrfs/$imageName

# TODO create snapshot and image directory

