# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require 'rvm/capistrano' # Add RVM integration
set :rvm_ruby_string, 'default'
set :rvm_type, :user
require 'bundler/capistrano' # Add Bundler integration
# only for rails 3.1 apps, this makes sure our assets are precompiled.
#load 'deploy/assets'

set :application, "EZNotes"
role :web, "132.216.65.186"   # Your HTTP server, Apache/etc
role :app, "132.216.65.186"   # This may be the same as your `Web` server
role :db,  "132.216.65.186", :primary => true # This is where Rails migrations will run

set :scm, :git
set :repository,  "https://github.com/mcgillosd/eznotes.git"
set :branch,   "master"

set :user, "deploy"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false