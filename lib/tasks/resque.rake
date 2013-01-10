require "resque/tasks"

#load the whole rails environment
task "resque:setup" => :environment
