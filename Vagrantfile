# Script based on https://github.com/p8952/bocker
$script = <<SCRIPT
(
echo "Installing packages"
rpm -i https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
yum install -y -q autoconf automake btrfs-progs gettext-devel git libcgroup-tools libtool python-pip emacs

echo "Creating btrfs filesystem"
fallocate -l 4G ~/btrfs.img
mkfs.btrfs ~/btrfs.img

mkdir -p /var/byod/btrfs /var/byod/images /var/byod/containers
touch /var/byod/btrfs/UNMOUNTED
mount -o loop ~/btrfs.img /var/byod/btrfs
btrfs subvolume create /var/byod/btrfs/debian

echo "Installing docker/undocker for pulling debian"
# Install docker from binaries. Yum packages conflicts with btrfs-progs
# Docker is only needed to pull the debian image
curl https://get.docker.com/builds/Linux/x86_64/docker-1.6.0 -o /bin/docker
chmod +x /bin/docker
# Start docker engine
docker -d &
pip install git+https://github.com/larsks/undocker
# Potential race condtion, if docker daemon isn't ready yet
docker pull debian
docker save debian | undocker -o /var/byod/btrfs/debian

# Snapshotting debian image
btrfs subvolume snapshot /var/byod/btrfs/debian /var/byod/btrfs/base-debian

echo "Installing util-linux"
git clone https://github.com/karelzak/util-linux.git
cd util-linux
git checkout tags/v2.28.1
./autogen.sh
./configure --without-ncurses --without-python
make
mv unshare /usr/bin/unshare
cd ..


echo 1 > /proc/sys/net/ipv4/ip_forward
iptables --flush
iptables -t nat -A POSTROUTING -o bridge0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE

ip link add bridge0 type bridge
ip addr add 10.0.0.1/24 dev bridge0
ip link set bridge0 up
) 2>&1
SCRIPT

Vagrant.configure(2) do |config|
	config.vm.box = 'puppetlabs/centos-7.0-64-nocm'
	config.ssh.username = 'root'
	config.ssh.password = 'puppet'
	config.ssh.insert_key = 'true'
	config.vm.provision 'shell', inline: $script
end
