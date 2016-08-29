#!/usr/bin/env bash
# Usage byod_exec.sh <pid of container> <container name> <cmd>
# For extra credit use container name to figure out pid. One possibility is
# to store the pid in a file in the container directory
conPid=$1
conName=$2
shift
cmd="$@"

conDir=/var/byod/containers/$conName

# TODO Enter namespace(s) file system for pid/container

