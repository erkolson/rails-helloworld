#!/usr/bin/env bash


apt-get update
apt-get install -y \
  ruby-full \
  rails

rails new helloworld
