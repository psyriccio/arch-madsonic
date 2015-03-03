#!/bin/bash

# define pacman packages
pacman_packages="libcups jre7-openjdk-headless fontconfig unzip"

# install pre-reqs
pacman -Sy --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# create destination directories
mkdir -p /opt/madsonic/media
mkdir -p /opt/madsonic/transcode

# unzip madsonic and transcode
unzip /opt/madsonic/madsonic.zip -d /opt/madsonic
unzip /opt/madsonic/transcode/transcode.zip -d /opt/madsonic/transcode

# remove source zip files
rm /opt/madsonic/madsonic.zip
rm /opt/madsonic/transcode/transcode.zip

# force process to run as foreground task
sed -i 's/-jar madsonic-booter.jar > \${LOG} 2>\&1 \&/-jar madsonic-booter.jar > \${LOG} 2>\&1/g' /opt/madsonic/madsonic.sh

# set permissions
chown -R nobody:users /opt/madsonic
chmod -R 775 /opt/madsonic

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*