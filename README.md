# Test plugin for ChiliProject/Redmine [![Build Status](https://secure.travis-ci.org/jnv/chiliproject_test_plugin.png?branch=master)](http://travis-ci.org/jnv/chiliproject_test_plugin)

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
`MAIN_REPO="git://github.com/chiliproject/chiliproject.git"`
URL of the Git repo with ChiliProject/Redmine which will use the plugin.
Defaults to [the official ChiliProjectrepository](https://github.com/chiliproject/chiliproject).

### REPO_NAME
`REPO_NAME=chiliproject_test_plugin`
Directory your plugin was cloned into by Travis, corresponds to the repository name.

### PLUGIN_NAME
`PLUGIN_NAME=chiliproject_test_plugin`
How your plugin is identified by Rails Engines, name of the plugin's directory in vendor/plugins.
Usually will be the same as `REPO_NAME`

### TARGET_DIR
`TARGET_DIR="$HOME/chiliproject"`
Directory the MAIN_REPO will be cloned into and from which the tests will be run.

## Environment

### DB

Defines adapter and database to use.
Supported adapters: `mysql`, `mysql2`, `postgres`

### BUNDLE_WITHOUT

Defines Gemfile groups to ignore (passed into `bundle install --without`).

### Example

Based on [ChiliProject's .travis.yml](https://github.com/chiliproject/chiliproject/blob/master/.travis.yml)

```shell
# Use mysql2, ignore postgres, mysql
DB=mysql2 BUNDLE_WITHOUT=rmagick:mysql:postgres:sqlite
```
