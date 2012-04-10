# Test plugin for ChiliProject/Redmine
[![Build Status](https://secure.travis-ci.org/jnv/chiliproject_test_plugin.png?branch=master)](http://travis-ci.org/jnv/chiliproject_test_plugin)

This is boilerplate/example plugin with [Travis CI](http://travis-ci.org/) integration.
CI scripts are based on [Radiant CMS extensions testing](https://github.com/radiant/radiant/wiki/How-to-enable-Travis-CI-for-an-extension).

## Usage

You will need at least the following files from this repository:
* `.travis.yml`
* `test/ci/before_script.sh`
* `test/ci/script.sh`
* `Gemfile` with `gem "rake"` which is not specified in ChiliProject's Gemfile but Travis requires it

Modify `.travis.yml` to suit your needs (see *Configuration* section), add additional RVMs and databases (currently MySQL and PostgreSQL are supported).

`before_script.sh` clones ChiliProject to the worker, copies the plugin into `vendor/plugins` and runs Bundler and migrations.
`script.sh` executes plugin's tests using the `test:engines:all` rake task.

## Configuration

Configuration is passed to the scripts using environment variables. Variables are defined in `before_install` section of `.travis.yml`.

### MAIN_REPO
`MAIN_REPO="git://github.com/jnv/chiliproject-fit.git"`
URL of the Git repo with ChiliProject/Redmine which will use the plugin.
Currently the source repo must contain `config/database.{mysql|postgres}.yml` files, hence the [official repository](https://github.com/chiliproject/chiliproject) is not used.

### REPO_NAME
`REPO_NAME=chiliproject_test_plugin`
Directory your plugin was cloned into by Travis, corresponds to the repository name.

### PLUGIN_NAME
`PLUGIN_NAME=chiliproject_test_plugin`
How your plugin is identified by Rails Engines, name of the plugin's directory in vendor/plugins.
Usually will be the same as `REPO_NAME`

### BUNDLE_ARGS
`BUNDLE_ARGS="--without development sqlite"`
Arguments passed to `bundle install`, add as much stuff to `--without` as possible to make builds faster and Travis happier.

### TARGET_DIR
`TARGET_DIR="$HOME/chiliproject"`
Directory the MAIN_REPO will be cloned into and from which the tests will be run.

