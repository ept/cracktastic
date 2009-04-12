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

# Add rspec & rspec_rails
git submodule add git://github.com/dchelimsky/rspec.git vendor/plugins/rspec
git submodule add git://github.com/dchelimsky/rspec-rails.git vendor/plugins/rspec_rails
ruby script/generate rspec
git add lib script/autospec script/spec script/spec_server spec
git commit -m 'Added rspec and rspec_rails'

# Add restful_authentication
git submodule add git://github.com/technoweenie/restful-authentication.git vendor/plugins/restful_authentication
ruby script/generate authenticated user sessions --include-activation --aasm --rspec
git add app/controllers/{users,sessions}_controller.rb app/helpers/{users,sessions}_helper.rb \
    app/models/user{,_mailer,_observer}.rb app/views/{sessions,user_mailer,users \
    config/initializers/site_keys.rb config/routes.rb features \
    lib/authenticated_{system,test_helper}.rb spec/{controllers,fixtures,helpers,models}
git commit -m 'Added restful_authentication'
git tag setup1

