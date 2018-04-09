#!/usr/bin/env bash

echo "i am"
whoami
echo "env"
env

echo "apt-get update"
apt-get update
echo "install ruby-full and rails"
apt-get install -y \
  ruby-full \
  rails

export HOME=/home/ubuntu

mkdir -p /webapp/helloworld
cd /webapp
echo "Generate new rails app helloworld"
rails new helloworld
cd /webapp/helloworld
echo "Launch helloworld app"
bin/rails s -p 80 -b 0.0.0.0
