#!/bin/sh

# Git repo of the ChiliProject/Redmine
#MAIN_REPO="git://github.com/chiliproject/chiliproject.git"
MAIN_REPO="git://github.com/jnv/chiliproject-fit.git"

# Name of your plugin's repo
REPO_NAME=chiliproject_test_plugin

# Plugin's name/directory
# usually will be same as $REPO_NAME
PLUGIN_NAME=chiliproject_test_plugin

# Where the cloned ChiliProject will be stored
TARGET_DIR=$HOME/chiliproject

# Prepare ChiliProject
git clone --depth=100 $MAIN_REPO $TARGET_DIR

cd $TARGET_DIR

# Copy over the already downloaded plugin 
cp -r ~/builds/*/$REPO_NAME vendor/plugins/$PLUGIN_DIR

export BUNDLE_GEMFILE=$TARGET_DIR/Gemfile

bundle install --without development sqlite #FIXME: support for bundler_args

echo "creating $DB database"
case $DB in
  "mysql" )
    mysql -e 'create database chiliproject_test;'
    cp spec/ci/database.mysql.yml config/database.yml;;
  "postgres" )
    psql -c 'create database chiliproject_test;' -U postgres
    cp spec/ci/database.postgres.yml config/database.yml;;
esac

bundle exec rake db:migrate
bundle exec rake db:migrate_plugins
