#!/usr/bin/env bash
SECONDS=0
clear

timezone=$(echo "$1")
#== Bash helpers ==
source /var/www/vagrant/provision/common.sh

#== Provision script ==

info "Provision-script user: `whoami`"

#This boot parameter controls the type of user interface used for the installer.
#https://www.debian.org/releases/sarge/s390/ch05s02.html.en
export DEBIAN_FRONTEND=noninteractive

info "[1] UPDATING LOCALES ..."
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
update-locale
locale-gen en_US.UTF-8


info "Allocate swap for MySQL 5.6"
fallocate -l 2048M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

info "Configure locales"
update-locale LC_ALL="C"
dpkg-reconfigure locales

info "Configure timezone"
echo ${timezone} | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

info "[2] UPDATING AND UPGRADING SYSTEM ..."
apt-get update
apt-get upgrade -y

info "[3] NGINX..."
apt-get install nginx -yq
cp /var/www/vagrant/default /etc/nginx/sites-available/
service nginx reload

info "[4] Node and NPM"

#Both the CLI and generated project have dependencies that require Node 6.9.0 or higher, together with NPM 3 or higher.
#https://github.com/nodesource/distributions
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get install -y nodejs

npm install -g @angular/cli

##https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md
info "Install additional software"
apt-get install git curl vim mc htop -yqq

nodejs -v
npm -v
nginx -v

duration=$SECONDS
info "done in $(($duration / 60)) minutes and $(($duration % 60)) seconds"