#!/usr/bin/env bash
SECONDS=0
clear

#== Bash helpers ==
source /var/www/vagrant/provision/common.sh

#== Provision script ==

info "Provision-script user: `whoami`"


cd /var/www

#https://github.com/mitchellh/vagrant/issues/6024
mkdir ~/node_modules
ln -s ~/node_modules node_modules
chmod  0777 node_modules -R

#Install these packages by opening a terminal window (command window in Windows) and running this npm command.
npm install

#npm install -g angular-cli

duration=$SECONDS
info "done in $(($duration / 60)) minutes and $(($duration % 60)) seconds"
