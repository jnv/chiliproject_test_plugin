#!/bin/sh

TARGET_DIR=$HOME/chiliproject

PLUGIN_NAME=chiliproject_test_plugin

cd $TARGET_DIR
pwd
echo "BUNDLE_GEMFILE:" $BUNDLE_GEMFILE
bundle list
bundle exec rake test:engines:all PLUGIN=$PLUGIN_NAME
