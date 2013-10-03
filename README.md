# IMPORTANT NOTE THIS README IS NOT FULLY UPDATED THERE IS SOME OUTDATED INFORMATION AND/OR MISSING INFORMATION READ AT YOUR OWN RISK DO NOT RELY ON THIS YET. CURRENTLY IT IS UNDER REPAIR AND THE FULL UPDATED VERSION WITH THE CORRECT INFO WILL BE OUT SOON. #

# Table Of Contents #
1. [General Information](#general-information)
	- [Project](#project)
	- [contact Info](#contact-info)
2. [Getting Started](#getting-started)

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

We are developing a web application that will allow the staff at the OSD to match students experiencing disabilities with
prospective note takers taking the same course so that they can share their notes. 

## Licensing ##
This project is licenced under the MIT open source initiative <http://opensource.org/licenses/MIT>  
All icons are from Font-Awesome <http://fortawesome.github.io/Font-Awesome/license/>

## Technologies ##

### Framework ###
Rails

### Programming Language(s) ###
-	Ruby
-	JQuery
-	Javascript
-	CoffeeScript
-	HTML

### Version Control ###
Git

### Database ###
PostgreSQL

### Testing/Development Deployment ###
Heroku <https://www.heroku.com/>

### Online tools ###
Wireframes <http://pencil.evolus.vn/>  
GitHub <https://github.com/mcgillosd/eznotes>

-------------------------------------------
# Getting Started #

The EZNotes web application was developed using the guide by Michael Hartl <http://ruby.railstutorial.org/> as spring board. If you
are a first time rubist and this is your first rails app I recommend to read and follow the tutorial
thoroughly.

## Installing Ruby and Rails ##

For Our purposes we are using Ruby version 2.0.0-p and Rails 4.0.0.  
To check the version of ruby installed on your system type `ruby -v` in command line.  
I strongly reccomend to use [Ruby Version Manager(RVM)]<http://rvm.io/> to install ruby.  
OS X Users must install Command line tools for Xcode.

To get started with Ruby Installation, first install RVM:  
`curl -L https://get.rvm.io | bash -s`  

If RVM is already installed run:  
`rvm get stable`

To get Ruby set up you can examine the requirements by running:  
`rvm requirements`

To install Ruby 2.0.0 run:  
`rvm install 2.0.0`

I suggest for the project to create a gemset which are self-contained bundles of gems in order to minimize potential conflicts due to gems updating.  
`rvm use 2.0.0@EZNotes_rails_4_0 --create --default`

You can type `which gem` to figure out if RubyGems is installed. By installing RVM you get RubyGems by default

if you dont have RubyGems you need to download it and go to the rubygems directory and run  
`ruby setup.rb`

If you have RubyGems installed make sure your system uses the version you want it to. i.e you want to freeze your system to a particular version to avoid conflicts when RubyGems changes in the future. In our case we are using version 2.0.0 so  
`gem update --system 2.0.0`

Finally we can install rails simply by running  
`gem install rails --version 4.0.0 --no-ri --no-rdoc`

Type `rails v` to verify the version of rails is 4.0.0

-------------------------------------------

-	Step 1: Install Git
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
We make use of Bootstrap, an open-source web design framework from twitter. Bootstrap uses LESS CSS. To use Bootstrap we include the bootstrap-sass gem.
Rails 3 uses HTML5 by default as indicated by <code> <!DOCTYPE html> </code>
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

Please note that with software that constantly updates and new versions getting released Google is your best friend A lot of the set up was done looking through different resources and references all of them can be found at the end of this section. 

## Server ##

### Physical Machine ###
Dell Machine 64 Bit

Server has a partition(split in half) has both windows 7 and linux installed. Linux parition is 103GB
The parititioning schemse is as follows
3 physical volumes and one logical volume
2 partitions(PV) for windows one is fat32 
the other is the windows installation at 139GB

2 partitions(1PV and 1LV) for ubuntu server

there is a physical boot partition of 250MB
then the there is a logical volume group with 3 logical volumes installed. one is root with size 30GB the other is swap at 8GB and the remaining diskspace is var which will contain the data for website i.e web site files databases and log files

has a static ip address

### Installation and setup ###

Running Ubuntu server 12.04.3 LTS AMD 64

Now update by running

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo reboot
```

It would be a good idea to set up automatic updates I did this as follows:

`sudo apt-get install unattended-upgrades`

`sudo vim /etc/apt/apt.conf.d/50unattended-upgrades`

uncomment security updates

```
Unattended-Upgrade::Allowed-Origins {
        "Ubuntu precise-security";
//      "Ubuntu precise-updates";
};
```
to enable automatic updates edit the following
`sudo vim /etc/apt/apt.conf.d/10periodic`

```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
```

1 says that it will update every day and 7 is weekly.

#### Setting up the hosts file ####

You can call your server anything you want
xxxx.xxxx.xxxx is replaced with the static ip that is set up
for the server machine in the OSD office

```
# /etc/hosts
127.0.0.1   localhost
xxx.xxx.xxx.xxx server.eznotes.ca

# /etc/hostname
server.eznotes.ca
```

#### Install curl and git ####
`sudo apt-get install curl`
`sudo apt-get install git-core`

### Permissions and Security ###
Create a deploy user in order to avoid doing anything through root. The deployment user had the password generated using LastPass.

#### Set up Firewall ####

We now are going to lock down our server a bit more by installing Shorewall, a command-line firewall. 
To install it:
`sudo aptitude install shorewall`

By default, Shorewall is installed with no rules, allowing complete access. However, this is not the behavior we want.
Instead, we’re going to block all connections to anything other than port 80 (HTTP) port, port 22 (SSH) and the port our server is running from. 

First, copy the configuration files to the Shorewall directory:
`sudo cp /usr/share/doc/shorewall-common/examples/one-interface/* /etc/shorewall/`

Now, open the “rules” file:
`sudo vim /etc/shorewall/rules`

Add these lines below where it says #Permit all ICMP Traffic...
```
ACCEPT	net	$FW	tcp 80
ACCEPT	net	$FW	tcp 22
ACCEPT	net	$FW	tcp OURPORTNUMBER
```

The firewall is now configured to only accept HTTP, HTTPS, SSH, and our port traffic. The last thing we need to do is tell Shorewall to start on boot. So, open up the main Shorewall configuration file:
`sudo vim /etc/shorewall/shorewall.conf`
Scroll down to `“STARTUP_ENABLED=No”` and set it to `“STARTUP_ENABLED=Yes”`

Now open the Shorewall default configuration file:
`sudo vim /etc/default/shorewall`

change 
`“startup=0″ to “startup=1″`

Finally, start your firewall:
`sudo /etc/init.d/shorewall start`

#### Setup SSH ####
Log in as root and modify /etc/ssh/sshd_config file
`sudo vim /etc/ssh/sshd_config`

change PermitRootLogin to now
add AllowUsers deploy

in this case our deployment non root user is called deploy

save and reload the SSH daemon
`sudo service ssh restart` or `sudo /etc/init.d/ssh restart`

If you want to check all current SSH connections to the server you can use the netstat command.
`netstat -algrep ssh`

#### Add RSA Key to Server ####

By adding an RSA key to the server the deploy user can access the server without needing to input the password everytime. Since I used a very strong password for the deploy user using the password generator from last pass it saves us some hassle and its fairly secure. This also becomes necessary to run remote commands from the deployment scripts without being interrupted by password prompts in particular for using Capistrano

On the remote server run the following
`sudo mkdir ~/.ssh`

On the local machine use OpenSSH to create an RSA key in ~/.ssh and copy it to the remote server authorized_keys file

`ssh-keygen -t rsa -b 2048 -C "You comment for the public key"`
`cat ~/.ssh/id_rsa.pub | ssh deploy@xxx.xxx.xxx.xxx 'cat - >> ~/.ssh/authorized_keys'`

log into the remove server
`ssh deploy@xxx.xxx.xxx.xxx`

run: `sudo chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh/`

As a sanity check check the permission of authorized_keys
`ls -la ~/.ssh | grep "authorized_keys"`

You should get something like the following output:
`-rw------- 1 deploy deploy 403 2013-04-5 11:55 authorized_keys`

On ssh directory
`ls -la ~ | grep ".ssh"`

you should get something like this:
`drwx----- 2 deploy deploy 4096 2103-04-05 11:55 .ssh`

## Installing Apache ##

`sudo apt-get update`

fix Locales
`sudo locale-gen en_US en_US.UTF-8 en_CA.UTF-8`
`sudo dpkg-reconfigure locales`

Install basic packages
`sudo apt-get install apache2 curl git build-essential zlibc zlib1g-dev zlib1g libcurl4-openssl-dev libssl-dev libopenssl-ruby apache2-prefork-dev libapr1-dev libaprutil1-dev libreadline6 libreadline6-dev`

### Installing and Setting up Postgresql ###

`sudo apt-get install postgresql postgresql-contrib`

First we need to change the PostgreSQL postgres user password

`sudo -u postgres psql postgres`

Set the password using the following command

`\password postgres`

Input password when prompted. Again in our case I used LastPass password generator to generate the password

`\q` to quit

change authentication configuration by changing ident to md5
`sudo vim /etc/postgresql/9.2/main/pg_hba/conf`
By doing this change you ensure that a password is needed to log into psql and that the password is encrypted.

`sudo /etc/init.d/postgresql reload`

To create databases:

`sudo -u postgres createdb {your-db-dev-name}`
`sudo -u postgres createdb {your-db-test-name}`
`sudo -u postgres createdb {your-db-production-name}`

### Install RVM ###

`curl -L https://get.rvm.io | sudo bash -s stable`

This will install RVM in a multi-user install. Next step is add the deploy user to the RVM user group.
```
sudo adduser deploy
sudo adduser deploy rvm
sudo adduser <yourusername> deploy
sudo adduser <yourusername> rvm
sudo chown -R deploy:deploy /var/www
sudo chmod g+w /var/www
```
### Install Ruby ###

`rvm list known`
`rvm install 2.0.0`
`rvm --default use 2.0.0`
`gem update --system`
`gem update`

### Install RAILS ###

`gem install rails`
`rails -v`

### Install Phusion Passenger ###

`sudo gem install passenger --pre`

`sudo passenger-install-apache2-module`

```
sudo a2enmod passenger
sudo service apache2 restart
```

### Configure Virtual Host to Point to App ###

The final step is to setup a custom virtual host to point Apache to the new app directly. In this way we wont need to specify the port number everytime.

To do that, I edited the file:
`sudo vim /etc/apache2/sites-available/eznotes`

```
<VirtualHost _default_:8443>
   # ServerName www.yourhost.com # Commented out for default
   DocumentRoot /var/www/eznotes/public # be sure to point to public
   <Directory /var/www/eznotes/public>
      AllowOverride all
      Options -MultiViews
   </Directory>
</VirtualHost>
```

I activated the new site.

`sudo a2ensite testapp`

I deactivated the default site.

`sudo a2dissite default`

And reloaded apache to enabled the new configurations.

`sudo service apache2 reload`


## Deployment Using Git and Capistrano ##

This is a critical step that facilitates the deployment process so its automated fast and efficient.

Capistrano in essence allows us to deploy our local Rails app that we are developing on our local development machine to the production server in one or two lines.

### Set up Deployment User ###

Add a group to your remote server called "deployers" that will have permissions to deploy to the server and run stuff without requiring full root/sudo access.

`sudo groupadd deployers`

Create a user (if you haven't already) that will be added to the "deployers" group for making all your deployments. This user should have super-user privileges. Then add the user you want to use for deployments to that group (the last argument is the username you want to add).

`sudo usermod -a -G deployers deploy`

Then, update permissions on your deployment path where you want your app's code to go (here, I'm assuming the user "deploy" owns that path). This will give the "deployers" group read and write access to all files and directories beneath /deploy/to/path.

```
sudo chown -R deploy:deployers /deploy/to/path
sudo chmod -R g+w /deploy/to/path
```

### Set up Capistrano ###

Capistrano is a Ruby gem that makes your deployment life a lot easier. It avoids the nightmare of having to manually copy files, logon to the server, run deployment tasks off the CLI. 

Installing Capistrano is as easy as adding it to your app's Gemfile and running bundle install. You don't need it on the production server, so you can just add it under the "development" group in your Gemfile.

```
group :development do
    gem 'capistrano'
end
```

And install with bundler (from your app's root).
`bundle install`

Once installed, you'll need to "capify" your project. This will generate a few files (namely /config/deploy.rb and /Capfile). The deploy.rb is where you can add or write custom scripts to help automate your deployment tasks and save your carpal tunnel for more important application programming.

```
cd /path/to/your/project
capify .
```

#### Capistrano settings ####


Once your project is capified, open up your editor of choice and modify /config/deploy.rb 

First, you need to tell Capistrano your app's name and the clone path to your app's remote repository.

```
set :application, "Your application's name"
set :repository, "git@github.com:your-username/your-repository-name.git"
```

Next, tell it where your app needs to be installed on your production server (this is the path to where you want your app to live, starting from your server's root). The path will be the location you pointed your server to.

```
set :deploy_to, "/path/to/your/app"
Set the type of repository you're using (e.g., GIT, SVN, etc.) and which branch you want to deploy from (usually "master").

set :scm, :git
set :branch, "master"
```

Set the user you want to use for your server's deploys.

`set :user, "deploy"`

Now, you could use the scm_passphrase setting to tell Capistrano the password to use for your deployment user, but I don't like the idea of storing my server password in a file I want to keep in my repository. This is why I setup my server with RSA keys that allow my dev machine access without the need for entering a password every time. But if you want to put it in your deployment script without using keys, you'd do it like this (although not recommended):

`set :scm_passphrase, "password"`

I change another setting called use_sudo to false so commands are executed with the user's permissions unless I specify otherwise. If you added your user to the "deployers" group (which has write-access to your app's directory tree) you probably won't need to use sudo much, if at all.

`set :use_sudo, false`

Set your rails environment (this is deploying to the production server, so I'm setting it to "production", but you might want to deploy to a staging server with a custom environment). You can re-use this variable in your scripts whenever you need to specify the environment so you only need to change it in one place to keep things DRY.

`set :rails_env, "production"`

Tell Capistrano how you'd like to make updates. There are many different ways of doing it, but for simplicity's sake, I'm going to stick with the most straight-forward method, namely copy. This will clone your entire repository (download it from the remote to your local machine) and then upload the entire app to your server.

`set :deploy_via, :copy`

You could alternatively use a faster method like remote_cache which will run a fetch from your server to your remote repository and only update what's changed, but that requires some additional authentication between your server and the remote repository. I just want to get you up and running first. Worry about optimizing the process later.

Next, you need to tell Capistrano about any special SSH options it should be aware of. For instance, my server is setup to use a custom port number and uses RSA keys for authentication to my Github account. So, I need to specify the port, and use what's called "agent forwarding" to connect to my remote repository (it sounds weird, but agent forwarding will make your life easier by using your local keys rather than those installed on your server). Read more about agent forwarding with this great article from Github.

`set :ssh_options, { :forward_agent => true, :port => 4321 }`

You can also specify how many releases Capistrano should store on your server's harddrive. This is handy in case you ever want to rollback to a previous version quickly in case your newly deployed code blew something up and you need to put out the fires. But you probably want this to be a finite number so you don't fill up your disk with inactive versions of your app. I keep five releases.

`set :keep_releases, 5`

Next, you should use the following setting to ensure any needed password prompts from SSH show up in your terminal so you can handle them.

`default_run_options[:pty] = true`

The last setting you need to handle is where on the internet Capistrano can find your server. This could be your domain name or the IP address. For our case this deployment is for a smallish MVP-type app where everything is on the same machine (database, app, server, etc.). In this case you can use Capistrano's server setting.

`server "server.eznotes.ca", :app, :web, :db, :primary => true`

If you want to do fancier deployments by splitting things up for scaling (like separating your database from your application server), you'll want to use Capistrano's "roles" to point it to the different places where things are installed. Use multiple roles instead of the server command (it accomplishes the same thing with greater granularity).

```
role :web, "web.example.com"
role :app, "app.example.com"
role :db, "db.somethingelse.com", :primary => true
```
That :primary => true part of the database role tells Capistrano that this is the location of your primary database. Read more about this in greater detail.

#### Connect ####


Before we get into the individual deployment tasks, check that all the settings you've just saved in deploy.rb are working properly. Run this command in a terminal from your app's root.

`cap deploy:setup`

This will SSH to your server and create some directories in the folder you specified with deploy_to where Capistrano will store your releases, and your shared files (e.g., logs, configs, static assets like uploads, etc.). If something goes wrong with permissions or SSH access, you'll see some error messages. Fix these before proceeding so you know you can actually make a connection to your server.

This should setup the following directories (if you've specified to install your app in /var/www/eznotes/):

```
/var/www/eeznotes/current
/var/www/eznotes/shared
/var/www/eznotes/releases
```

The releases directory is where copies of all your actual code are stored. shared is a place where you can put common, shared files like logs, static assets, and in our case, config files like database.yml. current is simply a symbolic link that points to the current release inside the releases directory (Capistrano updates this for you on each deploy, so don't worry about it).

If `deploy:setup` works, the next thing you can do is run the `deploy:check` command. This will check your local environment and your server and try to locate any possible issues. If you see any errors, fix them first, and then run the command again until you don't have any more errors.

`cap deploy:check`

Any number of things could go wrong here, but the most likely issues will be some sort of authentication or file permission issues with your server and the user you're logging in with SSH.

#### Setting up Database.yml ####

In order not to store our database password in plain text in github we have excluded the file database.yml from our repository by adding it to .gitignore file. This is critical as we do not want to store sensitive data like passwords in the repository. However, when you run Capistrano to update your server, it only copies the files that are in your repository (and Rails actually needs to use that database.yml file to hook up to your server's database, unless you don't plan on storing any data whatsoever). So, the problem is: we need to get that config file onto the server somehow, securely, and make sure Rails knows where to find it.

There are many different solutions out there for handling this issue, but the simplist solution and easiest solution I found was to  manually put the file on the server in a shared location that only I (and the app) have read-access to.

First, make a new config directory in the shared directory that Capistrano created.

```
ssh deploy@xxx.xxxx.xxxx
mkdir /var/www/eznotes/shared/config
```

Leave the server and back on your local machine, in your app's root directory, copy the database.yml file to the server

`scp ./config/database.yml  deploy@xxx.xxx.xxx.xxx:/var/www/eznotes/shared/config/database.yml`

I then hook it up to the app with a simple symbolic link that I create in my deployment script inside deploy.rb (see below).

Tasks
Now for the fun stuff. You can make all kinds of cool programming logic for different needs that you can run each time you deploy your app so it's all nicely automated (I like not thinking too hard :).

enter image description here

I put all my deployment tasks under the "deploy" namespace inside my deploy.rb file. You could make up your own namespaces if you want, to help you organize things. But I'm just going to go over some basic stuff, so I'll group all these tasks under "deploy". The format of the tasks looks like this:

namespace :deploy do
    desc "Human readable description of task"
    task :name_of_task_command do
        # do stuff
    end
end
The string defined by the desc command is what will show up when you run cap -T from the CLI on your application (this lists all the deployment tasks available in your app).

The basic deployment tasks you need to accomplish are as follows:

Update application code
Precompile assets
Update custom symlinks
Restart the server
Cleanup unneeded files
I used to need to make custom tasks for a lot of this stuff, but lucky for you, these days most of this is baked into Capistrano to make your life that much easier! I'll go over each task one by one. You can also tack on other things you need to do on deploy (like refresh your sitemap, restart/reindex your search engine, etc.) but I'm just going to stick with the basics for now (this article is already crazy long!)

1. Update Application Code
You don't need a special task for this. This is Capistrano's primary function. When you run cap deploy it will first update your code. However, if you want to only update your code and not do anything else, you can use the
cap deploy:update_code command to do it.

2. Precompile assets
Here's another freebie. I was handling asset compilation on my own until I started writing this article and discovered that this, too, is now baked into Capistrano (win). So instead of dealing with file-permission issues for generating asset files, all you have to do is uncomment this one line (that should already exist from when you capified your project) in the /Capfile file.

load 'deploy/assets'
This tells Capistrano to precompile assets on each deploy (it's commented out because for some reason there are other people out there using Capistrano for projects built with different frameworks than Ruby on Rails and don't need to run this task; go figure).

However, I ran into a Rails 4 gotcha in that Capistrano barfs while looking for a file called /path-to-app/shared/assets/manifest.yml on your server (at least as of version 2.14.2 which I'm using). Rails has changed the format of the manifest file to use JSON now in the format of
manifest-a5247d24f7c66d27d9b50f5c7e640bca.json. To get around this error, I simply created an empty version of the file Capistrano wants to see in the place it's looking for it. Read more about this issue.

On your remote server:

touch /path-to-your-app/shared/assets/manifest.yml
3. Update custom symlinks
This could be a link to some static assets you want to store outside your repository or something, but the main thing you need to do here is hook up your database.yml file so Rails can find it!

Rails expects to see /path/to/your/app/config/database.yml. But the file is now stored in /deploy_to/shared/config/database.yml. What to do? Here comes the magic of symbolic links. Add this task to your deploy.rb file.

desc "Symlink shared config files"
task :symlink_config_files do
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
end
4. Restart the server
Since the server is setup to run with Passenger, you'll need to override Capistrano's default restart task with one specific to Passenger (i.e., you want to touch /tmp/restart.txt from inside your app's root. This is pretty simple by adding this task to the "deploy" namespace in deploy.rb.

desc "Restart Passenger app"
task :restart do
    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
end
5. Cleanup unneeded files
This one comes baked in too, but I just wanted to highlight it because I sometimes forget :P If you don't run cleanup, the worst thing that will happen is that all your old releases stay stored on your server. But you might not want this as it's taking up disk space. This task is run from deploy:cleanup.

After Deploy
The final step in setting up your deployment script is to add your custom tasks to run after deployment (i.e., after all the files are copied to the server and the current_path has been updated to the latest release). All you need to do is tell Capistrano what tasks you want to run in the order you want to run them outside the deploy namespace block.

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
Since precompiling assets and updating the code are baked in, you don't need to specify those tasks. If you add any other tasks to your deployment process, you can just add them here to get executed.

Deploy!
Phew! Ok, now to actually do stuff. You should have a remote Git repository with the latest version of your code in it, Capistrano setup and checked, and your deployment tasks written and ready to run. So let's run it:

cap deploy
Sit back and watch all those characters flow over your terminal and feel good inside knowing the computer is saving you hours of frustration (if you aren't frustrated already, haha).

Oh, and if you need to simply migrate your database, Capistrano has a task for that too.

cap deploy:migrate
And if something goes horribly wrong (which will happen), you can quickly and easily rollback to the previous release (which is hopefully a working version).

cap deploy:rollback
Run this multiple times to go back through additional past releases.

Computer screens

Your regular routine can now be something like this:

change some stuff in your code
git add . it to your local repo queue
git commit -m 'my new commit' it to your local repo
git push origin master to sync it to your remote
cap deploy to update your production server with your changes
I wanted to go over installing ImageMagick with Paperclip for all your uploading needs, but I think I'll save that for a future post (I've already written too much). Thanks for reading, and like always, if you notice anything that could be improved, please let me know!



## Resources/References ##

### Installing Ubuntu server 12.04.3 LTS AMD 64 ###

<http://www.designervisuals.com/Manual_Partitioning_of_Ubuntu_Web_Server_using_LVM.html>

<http://www.designervisuals.com/Manual_Partitioning_Ubuntu_Web_Server.html>

<http://net.tutsplus.com/tutorials/php/how-to-setup-a-dedicated-web-server-for-free/>

<https://help.ubuntu.com/10.04/serverguide/automatic-updates.html>

<http://www.web-l.nl/posts/21-production-rails-on-ubuntu-12-04-lts>

### Postgres ###
<https://www.digitalocean.com/community/articles/how-to-install-and-use-postgresql-on-ubuntu-12-04>

### Security ###
<http://www.debian-administration.org/articles/349>
<http://httpd.apache.org/docs/2.2/ssl/ssl_faq.html>
<http://blog.ericlamb.net/2009/05/setting-up-a-linux-web-server/>
<http://www.jonathanmoeller.com/screed/?p=2097>

### Set up Rails on server ###
<http://robmclarty.com/blog/how-to-setup-a-production-server-for-rails-4>
<http://robmclarty.com/blog/how-to-deploy-a-rails-4-app-with-git-and-capistrano>
<http://www.web-l.nl/posts/21-production-rails-on-ubuntu-12-04-lts>
<http://coding.smashingmagazine.com/2011/06/28/setup-a-ubuntu-vps-for-hosting-ruby-on-rails-applications-2/>
