#!/usr/bin/env bash
# Usage byod_exec.sh <pid of container> <container name> <cmd>
# For extra credit use container name instead to figure out pid
conPid=$1
conName=$2
shift ; shift
cmd="$@"

conDir=/var/byod/containers/$conName
conFs=$(readlink $conDir/fs)

nsenter -t $conPid -m -u -i -p -n -- chroot $conFs $cmd
