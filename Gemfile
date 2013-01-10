source 'http://rubygems.org'

gem 'rails', '3.2.9'
gem 'mysql2'
gem 'devise'

#Javascript lib
gem 'jquery-rails'
gem 'jquery-ui-rails'

#Visual
gem 'will_paginate'                         #pagination
gem 'calendar_date_select'                  #show calendar to user to select
gem 'tabs_on_rails'                         #allow declaring tab for each controller

#Convenent coding
gem 'haml'                                  #shorter syntax to code layout 
gem 'hash_extension'                        #allow accessing hash like object: has.key in addition to hash[key]
gem 'carrierwave'                           #easy upload image to server

#interface to OS packages
gem 'mini_magick'                           #image manipulation: scale, crop, convert..
gem 'ruby-mp3info'                          #read and write mp3 tag
gem 'sidekiq'                               #background queue base on Redis

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'                #compress JS and CSS into smaller file
  gem 'execjs'                              #ruby interface to JS
  gem 'therubyracer', :platforms => :ruby   #one of many JS runtime
  gem 'libv8'                               #need to have this to make therubyracer works. This expose OS libv8 to ruby
end

group :development do
# Deploy with Capistrano
 gem 'capistrano'
 gem 'capistrano-ext'
 gem 'rvm-capistrano'                       #support instructing capistrano to choose which ruby version from rvm
 gem 'debugger'
end
