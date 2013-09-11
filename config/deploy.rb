require 'bundler/capistrano' # Add Bundler integration
require 'rvm/capistrano' # Add RVM integration

load 'deploy/assets'
set :default_shell, :bash
set :rvm_ruby_string, :local

# specify the name of the application on the server
set :application, "eznotes"
# specify the full repository location where the server will pull updates from
set :repository,  "https://github.com/mcgillosd/eznotes.git"
# specify path on the server to deploy the application
set :deploy_to, "/var/www/#{application}"
# specify the version control system used
set :scm, :git
# specify the branch to fetch
set :branch,   "master"
# specify the user
set :user, "deploy"
# for security make sure sudo is not used
set :use_sudo, false
# specify the rails environment to launch
set :rails_env, "production"
# specify how to fetch the data use copy for simpler fetching protocol
set :deploy_via, :remote_cache
# if using forwarding
set :ssh_options, { :forward_agent => true }
# specify how many versions you want to keep in order to rollback
# for space reasons and so the server is not bogged down with versions
set :keep_releases, 5
# so that if there is a prompt anywhere it will show up on console
default_run_options[:pty] = true

role :web, "132.216.65.186"   # Your HTTP server, Apache/etc
role :app, "132.216.65.186"   # This may be the same as your `Web` server
role :db,  "132.216.65.186", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Symlink shared config files"
  task :symlink_config_files do
   run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ latest_release }/config/database.yml"
   run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/application.yml #{ latest_release }/config/application.yml"
   #run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end

  # NOTE: I don't use this anymore, but this is how I used to do it.
  # desc "Precompile assets after deploy"
  # task :precompile_assets do
  #   run <<-CMD
  #     cd #{ current_path } &&
  #     #{ sudo } bundle exec rake assets:precompile RAILS_ENV=#{ rails_env }
  #   CMD
  # end

   desc "Restart applicaiton"
   task :restart do
     run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
   end
 end

 before "deploy:setup", 'rvm:install_rvm'
 before "deploy:setup", 'rvm:install_ruby'
 before "deploy:assets:precompile", "deploy:symlink_config_files"
 #before 'bundle:install', 'deploy:symlink_config_files'
 #after "deploy:update", "deploy:symlink_config_files"
 after "deploy", "deploy:restart"
 after "deploy", "deploy:cleanup"
