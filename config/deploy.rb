set :application, "PAS"
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:lnthai2002/PAS.git"
set :scm, "git"
#set :user, "deployer"  # The server's user for deploys
#set :scm_passphrase, "p@ssw0rd"  # The deploy user's password
set :deploy_to, "/var/www/PAS"

role :web, "darkportal.no-ip.info"                          # Your HTTP server, Apache/etc
role :app, "darkportal.no-ip.info"                          # This may be the same as your `Web` server
role :db,  "darkportal.no-ip.info", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  task :copy_database_configuration do
    production_db_config = "/home/nhut_le/production.database.yml"
    run "cp #{production_db_config} #{release_path}/config/database.yml"
  end
  after "deploy:update_code" , "deploy:copy_database_configuration"
end
