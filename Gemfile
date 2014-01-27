source 'http://rubygems.org'

gem 'rails', '4.0.1'
gem 'mysql2'
gem 'devise'
gem "rubycas-client", :git=>"https://github.com/rubycas/rubycas-client.git"
gem 'cancan'

#engines
gem 'cooking', :path => "vendor/engines/cooking"
gem 'financial', :path => "vendor/engines/financial"
gem 'music', :path => "vendor/engines/music"

#Javascript lib
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'remotipart'                            #allow submit ajax form with multipart 

#Visual
gem 'will_paginate'                         #pagination
gem 'calendar_date_select'                  #show calendar to user to select
gem 'tabs_on_rails'                         #allow declaring tab for each controller
gem 'foundation-rails'                      #foundation UI framework

#Convenent coding
gem 'haml-rails'                            #shorter syntax to code layout 
gem 'hash_extension'                        #allow accessing hash like object: has.key in addition to hash[key]
gem 'carrierwave'                           #easy upload image to server
gem 'dynamic_form'
gem 'money-rails'
gem 'ice_cube'

#interface to OS packages
gem 'mini_magick'                           #image manipulation: scale, crop, convert..
gem 'ruby-mp3info'                          #read and write mp3 tag
gem 'whenever'

# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'                            #compress JS and CSS into smaller file
gem 'execjs'                              #ruby interface to JS
#gem 'therubyracer', :require => 'v8'     #one of many JS runtime

group :development, :test do
# Deploy with Capistrano
 gem 'capistrano'
 gem 'capistrano-ext'
 gem 'rvm-capistrano'                       #support instructing capistrano to choose which ruby version from rvm
 gem 'rspec-rails'                          #test support
 gem 'factory_girl_rails'                   #to create mock data for testing
 gem 'rails_layout'
 gem 'byebug'
end
