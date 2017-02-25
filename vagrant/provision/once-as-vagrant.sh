#!/usr/bin/env bash
SECONDS=0
clear

#== Bash helpers ==
source /var/www/vagrant/provision/common.sh

#== Provision script ==

info "Provision-script user: `whoami`"
alias app='cd /var/www'


cd /var/www

#https://github.com/mitchellh/vagrant/issues/6024
#mkdir /node_modules
mkdir /home/vagrant/node_modules
ln -s /home/vagrant/node_modules /var/www/
ln -s /home/vagrant/node_modules /var/www/src/

#ln -s /node_modules /var/www/
#ln -s ~/node_modules src/node_modules

#mkdir /home/vagrant/node_modules
#mkdir /home/vagrant/node_modules2
#ln -s /home/vagrant/node_modules  /tmp/

chmod  0777 ./node_modules -R
chmod  0777 ./src/node_modules -R

#Install these packages by opening a terminal window (command window in Windows) and running this npm command.
npm install

#alias node='nodejs'

duration=$SECONDS
info "done in $(($duration / 60)) minutes and $(($duration % 60)) seconds"
