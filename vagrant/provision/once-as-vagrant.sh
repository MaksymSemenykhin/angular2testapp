#!/usr/bin/env bash
SECONDS=0
clear

#== Bash helpers ==
source /var/www/vagrant/provision/common.sh

#== Provision script ==

info "Provision-script user: `whoami`"


cd /var/www

sudo npm install -g

rm ./src/dist/* -rf
npm run start

duration=$SECONDS
info "done in $(($duration / 60)) minutes and $(($duration % 60)) seconds"
