#!/bin/sh

# Git repo of the ChiliProject/Redmine

# Prepare ChiliProject
git clone --depth=100 $MAIN_REPO $TARGET_DIR
cd $TARGET_DIR
#git submodule update --init --recursive

# Copy over the already downloaded plugin 
cp -r ~/builds/*/$REPO_NAME vendor/plugins/$PLUGIN_DIR

#export BUNDLE_GEMFILE=$TARGET_DIR/Gemfile

bundle install $BUNDLER_ARGS

echo "creating $DB database"
case $DB in
  "mysql" )
    mysql -e 'create database chiliproject_test;'
    cp config/database.mysql.yml config/database.yml;;
  "postgres" )
    psql -c 'create database chiliproject_test;' -U postgres
    cp config/database.postgres.yml config/database.yml;;
esac

bundle exec rake db:migrate
bundle exec rake db:migrate:plugins
