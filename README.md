# General Information #

## Project ##

EZNotes@McGillOSD

## Contact Info ##

McGill Office for Students with Disabilities  
Redpath Library Building, Suite RS56  
3459 McTavish Street  
Montreal, Quebec  
H3A 0C9  

514-398-6009

<http://www.mcgill.ca/osd/contact>

Andrew Bennett, B.A.  
Administrative Coordinator  
Email: andrew.bennett@mcgill.ca  

## Developers ##

Wisam Al Abed  
wisam.alabed@mail.mcgill.ca  
<http://ca.linkedin.com/in/wisamalabed>  

## Project Summary ##

What problem is this project solving?  

We are developing a web application that will match  
students with disabilities with prospective students  
taking the same course so that they can share their notes  
. TODO

## Technologies ##

### Framework ###
Rails

### Programming Language(s) ###
-	Ruby
-	JQuery
-	Javascript
-	HTML

### Version Control ###
Git

### Database ###
PostgreSQL

### Testing/Development Deployment ###
Heroku <https://www.heroku.com/>

## Online tools ##
Wireframes <http://pencil.evolus.vn/>  
GitHub <https://github.com/mcgillosd/eznotes>

-------------------------------------------
# Getting Started #

Almost everything was based on the rails guide by Michael Hartl <http://ruby.railstutorial.org/>. If you
are a first time rubist and this is your first rails app I recommend to read and follow the tutorial
thoroughly.

## Installing Ruby and Rails ##

for installing Ruby and Rails on OS X follow this link:  
<http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/#step-7>  

here is a summary

-	Step 1: Download and Install the Command Line Tools (via Xcode or the standalone installer)
-	Step 2: Verify that GCC was installed
-	Step 3: Install Homebrew
-	Step 4: Install Git
-	Step 5: Configure Git with your Name and Email
-	Step 6: Install RVM with the latest Ruby (2.0.0) and Rails (3.2.13)
-	Step 7: Load RVM into your shell session as a function
-	Step 8: Installing other versions of Ruby, such as 1.9.3

## Creating a Rails Application ##

`rails new` will create a skeleton Rails application in a directory of your choice. To get started, make a
directory for your Rails projects and then run `rails new` to make the first application.

### Summary of Rails Application Directory Structure ###

| **File/Directory**	| 												**Purpose**												 		 |
| ------------------ |:-------------------------------------------------------------------------------------:|
| app/					| Core application (app) code, including models, views, controllers, and helpers  		 |
| app/assets 			| Applications assets such as cascading style sheets (CSS), JavaScript files, and images|
| config/				| Application configuration 																			 	 |
| db/						| Database files 																								 |
| doc/					| Documentation for the application 																	 |
| lib/					| Library modules 																							 |
| lib/assets 			| Library assets such as cascading style sheets (CSS), JavaScript files, and images 	 |	
| log/					| Application log files 																					 |
| public/				| Data accessible to the public (e.g., web browsers), such as error pages 					 |
| script/Rails 		| A script for generating code, opening console sessions, or starting a local server 	 |
| test/					| Application tests (made obselete by the spec/ directory) 										 |
| tmp/					| Temporary files 																							 |
| vendor/				| Third-party code such as plugins and gems 															 |
| vendor/assets 		| Third-party assets such as cascading style sheets (CSS), JavaScript files, and images |
| README.rdoc 			| A brief description of the application( changed to README.md to use Github's markdown)|
| Rakefile 				| Utility tasks available via the `rake` command 													 |
| Gemfile 				| Gem requirements for this app 																			 |
| Gemfile.lock 		| A list of gems used to ensure that all copies of the app use the same gem versions 	 |
| config.ru 			| A configuration file for [Rack middleware](http://rack.rubyforge.org/doc/) 				 |
| .gitignore 			| Patterns for files that should be ignored by Git 												 |

## Using *Bundler* to install the included gems needed by the app ##
once you have assembed the proper and correct GemFile run  
$ `bundle update`  
$ `bundle install`  

## Running a local web server ##
use `rails server`. To see the result visit <http://localhost:3000/>  

# Installing PostgreSQL #

The easiest way is to follow the tutorial at <http://robdodson.me/blog/2012/04/27/how-to-setup-postgresql-for-rails-and-heroku/> and/or <http://railscasts.com/episodes/342-migrating-to-postgresql>

To install PostgreSQL locally on your machine use homebrew <https://wiki.postgresql.org/wiki/Homebrew>
```
brew install postgresql
initdb /usr/local/var/postgres
pg_ctl -D /user/local/var/postgres -l /user/local/var/postgres/server.log start
which psql
rails new  blog -d postgresql
rake db:create:all
```

Note following the advice from the tutorial i created aliases in my .bash_profile to start stop and check the status of the server. I found this very useful.  
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'  
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'  
alias pg-status='pg_ctl status -D /usr/local/var/postgres'  

update the gem file of your app to eliminate the sqlite3 gem and add the pg gem.
open config/database.yml file. I set it up as follows  
```
# postgresql version 9.2.2.x'
#   gem install pg
#
#   Ensure the pg gem is defined in your Gemfile
#   gem 'pg'
development:
  adapter: postgresql
  encoding: unicode
  database: EZNotes_development
  pool: 5
  timeout: 5000
  host: localhost


# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test: &test
  adapter: postgresql
  database: EZNotes_test
  pool: 5
  timeout: 5000
  host: localhost


production:
  adapter: postgresql
  database: EZNotes_production
  pool: 5
  timeout: 5000
  ```
# Setting up CSS #
We make use of Bootstrap, an open-source web design framework from twitter.
# Setting up Git #

## First-time system setup ##
perform one time system setups.  
`$ git config --global user.name "Your Name"`  
`$ git config --global user.email your.email@example.com`  

if you like using `co` in place of the more verbose `checkout` command then run
`$ git config --global alias.co checkout`

## First-time repository setup ##
navigate to the root directory of your app and run  
`$ git init`

The next step is to add the project files to the repository. Git tracks all changes so if you want to ignore 
certain files then you need to edit .gitignore

## Adding and committing ##
`$ git add . `  

the . will add files recursively so it automatically includes subdirectories

`$ git status `

This command will tell you what changes are ready to be committed

`$ git commit -m "Initial commit"`

This will perform a local commit on your machine. in order to commit to the remote repository like github you need to perform a `git push`

`$ git log`  
will display the list of your commit messages

## GitHub ##
to push your application to GitHub type  
`$ git remote add origin https://github.com/<username>/first_app.git`  
`$ git push -u origin master`  

This command tells Git that you want to add GitHub as the origin for you main (master) branch and then push
your repository up to GitHub. Make sure to replace <username> with your actual username. For example the command i ran was:  
`$ git remote add origin https://github.com/ElectronMan/EZNotes.git`

note on most systems after performing the above command for the first time any further subsequent pushes we can 
omit origin and just run `$ git push`

# Deploying #
We are taking the approach of deploying our Rails application early and often to production in order to faciliate
catching any deployment problems early as opposed to deploying only at the end after much effort was put into
developing the app.

We are using Heroku to deploy our application which makes things easy as long as the source code is under version control with Git.

## Heroku Setup ##

Heroku uses PostgreSQL database we need to add pg gem to our GemFile and run `bundle install` and push new gemfile to Git and GitHub.  

We have to configure a new Heroku account.
-	First [sign up for Heroku](https://id.heroku.com/signup)
-	Second install necessary Heroku software using [Heroku Toolbelt](https://toolbelt.heroku.com/)
-	Third use the heroku command to log in at the command line: `heroku login`
-	Fourth use the `heroku` command to create a place on the Heroku servers for your app to live:
		- `heroku create`

## Heroku Deployment, in one step ##
To deploy the application, use Git to push to Heroku  
`$ git push heroku master`

To open the web page deployed on Heroku you can run  
`$ git heroku open`

## Heroku commands ##
There are many [Heroku commands](https://devcenter.heroku.com/categories/command-line) you can use.
If you want to rename your application you can run  
`$ heroku rename EZNotes`. you can also change the name from the app settings page on heroku.com

For development we generated a reasonably secure random/obscure subdomain such as hsjceevf.herokuapp.com. We did this by running `ruby -r "print ('a'..'z').to_a.shuffle[0..7].join"` on the command line.

## Running the app ##

### Running locally ###

### Running on Heroku ###

-------------------------------------------
# Testing #

## Test suites ##
-	RSpec: used for test driven development
-	Capayara: A gem that allowed us to simulate user's interaction with the app using a natural english-like syntax
-	Guard: Automated running of tests.
-	Spork: Test server that speeds up the running of future tests.

## Configure Rails to use RSpec ##
Run the command `rails generate rspec:install`
Note you need the postgres server running locally for this to work.

## Eliminating bundle exec ##

RVM includes Bundler integration as of version 1.11 so this is the easiest way to eliminate having to type bundle exec everytime.  
To verify the version of RVM running on your machine type:   
```
$ rvm get head && rvm reload
$ rvm -v
```
## Automated test with Guard ##
We use Guard to automate the running of the tests. Guard monitors changes in the filesystem so that when a change occurs it runs the tests that are relevant to that change.

First add guard-rspec to the Gemfile.

Next run `bundle install` 

Next initialize Guard so that it works with RSpec  
`$ bundle exec guard init rspec` if you correctly eliminated the use of bundle exec then you can simply type `$ guard init rspec`

Next edit the resulting Guardfile  
```
require 'active_support/core_ext'

guard 'rspec', :all_after_pass => false do
	.
	.
	.
  # Allow Guard to run the right tests when the integration test and view are updated
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) do |m|
    ["spec/routing/#{m[1]}_routing_spec.rb",
     "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
     "spec/acceptance/#{m[1]}_spec.rb",
     (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" : 
                       "spec/requests/#{m[1].singularize}_pages_spec.rb")]
   end
   watch(%r{^app/views/(.+)/}) do |m|
    (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" :
                      "spec/requests/#{m[1].singularize}_pages_spec.rb")
   end
	.
	.
	.
end
```
Now you can start guard in its own terminal by running `guard`.

## Speeding up tests with Spork ##

First add guard-spork, childprocess, and spork to the gemfile.

Second Install Spork using `$ bundle install`

Third bootstrap the Spork configuration `$ spork --bootstrap`

Fourth edit the RSpec configuration file located in spec/spec_helper.rb
```
require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
```

Fifth add --drb option to .rspec file  
```
--colour
--drb
```
### Running Guard with Spork ###
`guard init spork`

change the Guardfile as follows
```
require 'active_support/core_ext'

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')
  watch('test/test_helper.rb')
  watch('spec/support/')
end

guard 'rspec', :all_after_pass => false, :cli => '--drb' do
	.
	.
	.
end
```

Now if you run guard it will automatically start a Spork server which will reduce the overhead of running tests each time.

-------------------------------------------
# Staging and Production Environments #