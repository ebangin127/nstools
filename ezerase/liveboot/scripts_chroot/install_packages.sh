export HOME=/root
export LC_ALL=C
cd /
apt-get install -t sid --no-install-recommends --yes \
util-linux linux-image-amd64 live-boot systemd systemd-sysv \
xserver-xorg-core xserver-xorg xinit &&
apt-get -t stretch --no-install-recommends --yes install \
python3-tk xterm nano hdparm xli slim blackbox fonts-nanum
