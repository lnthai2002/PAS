#install gems when deploy 
require "bundler/capistrano"

#declaration to use with user based RVM, rails 1.9.2, gemset pas
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2-p290@pas'
set :rvm_type, :user

#declare multi-stage deployment
require 'capistrano/ext/multistage'
set :stages, %w(production uat)
set :default_stage, "uat"

set :application, "pas"

#declare repository
set :scm,        :git
set :repository, "git@github.com:lnthai2002/PAS.git"
set :migrate_target, :current
set :use_sudo, false
set :ssh_options, {:forward_agent => true}

#overive release variable with current
set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

#overive revision with git version
set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

default_run_options[:shell] = 'bash'

namespace :deploy do
  desc "Deploy and restart"
  task :default do
    update
    restart
  end

  desc "Setup git base deployment, no releases dir"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end
  
  task :cold do
    update
    migrate
  end
  
  task :update do
    transaction do
      update_code
    end
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end
  
  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end
  
  desc "Restart passenger with restart.txt"
  task :restart, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Overwrite database.yml with the protected file on prod machine"
  task :copy_database_configuration do
    run "cp #{db_config_loc} #{release_path}/config/database.yml"
  end
  after "deploy:update_code" , "deploy:copy_database_configuration"

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end
    
    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end
    
    desc "Rolls back to the previously deployed version."
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end