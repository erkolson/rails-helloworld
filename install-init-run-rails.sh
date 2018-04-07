#!/usr/bin/env bash


apt-get update
apt-get install -y \
  ruby-full \
  rails

rails new helloworld
cd helloworld
bin/rails s -p 80 -b 0.0.0.0
