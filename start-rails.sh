#!/usr/bin/env bash

#apt-get install zlib1g-dev
#apt-get install build-essential g++
#apt-get install libpq-dev
#apt-get install libsqlite3-dev

cd /vagrant
bundle install
rails server -d -b 0.0.0.0