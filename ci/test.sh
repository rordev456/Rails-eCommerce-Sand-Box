#!/bin/bash

set -e -x
pushd Rails-eCommerce-Sand-Box
  apt-get update -qq && apt-get install -y build-essential mysql-client nodejs
  bundle install
  bundle exec rake
popd
