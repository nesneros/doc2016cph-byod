#!/usr/bin/env bash

# Start a container 
# Usage: byod-start <containerName> cmd...
conName=$1
shift
cmd="$@"
conDir=/var/byod/containers/$conName

conFs=/var/byod/btrfs/con$conName

function setupNetwork {
    # Return if byod interfaces already created
    [[ -f /var/run/netns/netns_byod ]] && return
    ip link add dev byod0 type veth peer name byod1
    ip link set dev byod0 up
    ip link set byod0 master bridge0
    ip netns add netns_byod
    ip link set byod1 netns netns_byod
    ip netns exec netns_byod ip link set dev lo up
    ip netns exec netns_byod ip link set byod1 address 02:42:ac:11:00:42
    ip netns exec netns_byod ip addr add 10.0.0.42/24 dev byod1
    ip netns exec netns_byod ip link set dev byod1 up
    ip netns exec netns_byod ip route add default via 10.0.0.1
}

# For network isolation call setupNetwork
#setupNetwork

# TODO execute cmd with proper chroot and unshare
# For network isolation use: ip netns exec netns_byod <command>



