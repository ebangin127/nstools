export HOME=/root
export LC_ALL=C
cd /
apt-get -t stretch --no-install-recommends --yes install \
util-linux
apt-get -t jessie-backports --no-install-recommends --yes install \
linux-image-amd64 &&
apt-get -t jessie --no-install-recommends --yes install \
live-boot xserver-xorg-core xserver-xorg xinit xterm \
nano hdparm python3-tk xli slim blackbox fonts-nanum