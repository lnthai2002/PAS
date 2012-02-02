#pulling from UAT branch
set :branch,     "origin/uat"
set :rails_env, 'uat'

#declare test servers
default_environment["RAILS_ENV"] = 'uat'
role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true # This is where Rails migrations will run
set :deploy_to, "/var/www/PAS"
set :user, "nhut_le" #user on production server to deploy
set :use_sudo, false

set :db_config_loc, "/home/nhut_le/#{rails_env}.database.yml"