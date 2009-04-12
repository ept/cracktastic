#!/bin/sh

# This script bootstraps the demo project, creating it from scratch using
# Rails generators. To run it, you must have a git clone of the invoicing-demo
# repository, and you must be currently at the head of the master branch.
# Then type:
#   ./setup.sh
#
# To see what's going on, simply run the commands one by one and review the
# results.
#
# WARNING: Uncommitted changes in your master branch will be discarded, and
# the branch called 'generated' will be removed entirely.

# Create a new git branch to which we will commit the auto-generated webapp;
# delete any existing branch of the same name.
git checkout master
git clean -f -d -x
git branch -D generated
git checkout -b generated

# Generate skeleton
rails --database=mysql .
git add README Rakefile app config doc public script test
git commit -m 'Generated rails project structure'

# Add rspec & restful authentication
git submodule add git://github.com/dchelimsky/rspec.git vendor/plugins/rspec
git submodule add git://github.com/dchelimsky/rspec-rails.git vendor/plugins/rspec_rails
git submodule add git://github.com/technoweenie/restful-authentication.git vendor/plugins/restful_authentication

