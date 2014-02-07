require "rvm/capistrano"                              #use RVM
require "bundler/capistrano"                          #use bundler
require "whenever/capistrano"                         #update cron when deploy
set :whenever_command, "bundle exec whenever"

load "deploy/assets"                                  #compile asset when deploy
default_run_options[:pty] = true                      #must be set for the password prompt from git to work

set :scm, "git"                                       #deploy from git repository
set :repository, "git@github.com:lnthai2002/PAS.git"  #location of repository
set :ssh_options, {:forward_agent => true}            #use ssh key when deploy
set :deploy_via, :remote_cache                        #dont clone repo each deployment but pull difference only
set :git_enable_submodules, 1                         #update/deploy submodule
set :keep_releases, 2                                 #keep maximum 2 release

require 'capistrano/ext/multistage'                   #multi-stage deployment
set :stages, %w(production uat)
set :default_stage, "uat"

set :application, "pas"                               #name of application

set :shared_children, shared_children + %w{public/cooking tmp/sessions}    #share cooking upload folder accross deployment

namespace :deploy do
  after "deploy:update_code" , "deploy:copy_database_configuration"

  desc "Overwrite database.yml with the protected file on prod machine"
  task :copy_database_configuration do
    run "cp #{db_config_loc} #{release_path}/config/database.yml"
  end

  desc "Restart passenger with restart.txt"
  task :restart, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end