#!/bin/sh

# This script bootstraps the demo project, creating it from scratch using
# Rails generators. To run it, you must have a git clone of the cracktastic
# repository, and you must be currently at the head of the master branch.
# Then type:
#   ./setup.sh
#
# To see what's going on, simply run the commands one by one and review the
# results.

# Generate skeleton
rails --database=mysql .
git add README Rakefile app config doc public script test
git commit -m 'Generated rails project structure'

# Add rspec & rspec_rails
git submodule add git://github.com/dchelimsky/rspec.git vendor/plugins/rspec
git submodule add git://github.com/dchelimsky/rspec-rails.git vendor/plugins/rspec_rails
git submodule update --init
ruby script/generate rspec
git add lib script/autospec script/spec script/spec_server spec
git commit -m 'Added rspec and rspec_rails'

# Add restful_authentication
git submodule add git://github.com/technoweenie/restful-authentication.git vendor/plugins/restful_authentication
git submodule update --init
ruby script/generate authenticated user sessions --include-activation --aasm --rspec
git add app/controllers/{users,sessions}_controller.rb app/helpers/{users,sessions}_helper.rb \
    app/models/user{,_mailer,_observer}.rb app/views/{sessions,user_mailer,users} \
    config/initializers/site_keys.rb config/routes.rb features \
    lib/authenticated_{system,test_helper}.rb spec/{controllers,fixtures,helpers,models}
git commit -m 'Added restful_authentication'

# Add companies (e.g. customers)
script/generate scaffold company is_self:boolean name:string contact_name:string address:text \
    city:string state:string postal_code:string country:string country_code:string tax_number:string
git add app/views/companies app/views/layouts/companies.html.erb app/controllers/companies_controller.rb \
    test/functional/companies_controller_test.rb app/helpers/companies_helper.rb config/routes.rb \
    app/models/company.rb test/unit/company_test.rb test/fixtures/companies.yml public/stylesheets/scaffold.css
git commit -m 'Added companies scaffolding'

# Add jokes
script/generate scaffold joke question:text answer:text
git add app/views/jokes app/controllers/jokes_controller.rb test/functional/jokes_controller_test.rb \
    app/helpers/jokes_helper.rb config/routes.rb app/models/joke.rb test/unit/joke_test.rb \
    test/fixtures/jokes.yml app/views/layouts/jokes.html.erb
git commit -m 'Added jokes scaffolding'

# Add purchases
script/generate model purchase company_id:integer user_id:integer joke_id:integer
git add app/models/purchase.rb test/unit/purchase_test.rb test/fixtures/purchases.yml
git commit -m 'Added purchase model'

# Combine all the up-migrations into one initial migration
echo 'class InitialSetup < ActiveRecord::Migration' >  migration.rb
echo '  def self.up'                                >> migration.rb
for file in `ls db/migrate`
do
  echo "    # Migrations from $file"                >> migration.rb
  sed -e '0,/^  def self\.up/d' -e '/^  end/,$d' db/migrate/$file >> migration.rb
  echo ''                                           >> migration.rb
done

# Pre-populate the database with some test data
cat initial_data.rb                                 >> migration.rb
echo '  end'                                        >> migration.rb
echo ''                                             >> migration.rb

# Combine all the down-migrations into the initial migration
echo '  def self.down'                              >> migration.rb
for file in `ls db/migrate | sort -r`
do
  echo "    # Migrations from $file"                >> migration.rb
  sed -e '0,/^  def self\.down/d' -e '/^  end/,$d' db/migrate/$file >> migration.rb
  echo ''                                           >> migration.rb
done
echo '  end'                                        >> migration.rb
echo 'end'                                          >> migration.rb

# Replace all the existing migrations with the new combined one
rm db/migrate/*.rb
mv migration.rb db/migrate/00000000000000_initial_setup.rb
git add db
git commit -m 'Combined initial database migrations'

