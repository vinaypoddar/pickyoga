# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "pickyoga"
set :repo_url, "git@github.com:vinaypoddar1/pickyoga.git"

# Setting the type of repository and branch
# set :scm, :git
# set :branch, "master"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/html/pickyoga.com"

# Setting the user for deployment
set :user, "root"
# Setting the user for deployment
# TODO -- setup the server with RSA keys that allow my dev machine
# to access without the need for entering a password every time
set :scm_passphrase, "#*preFETCH19"

# Commands will now be executed without user's permissions.
# User is root (which has write-access to your app's directory tree)
# you probably won't need to use sudo much, if at all.
set :use_sudo, false

# Setting rails environment to production
set :rails_env, "production"

# Tell Capistrano how you'd like to make updates.
# There are many different ways of doing it, but for simplicity's sake,
# I'm going to stick with the most straight-forward method, namely copy.
# This will clone your entire repository (download it from the remote 
# to your local machine) and then upload the entire app to your server.
set :deploy_via, :copy
# You could alternatively use a faster method like remote_cache
# which will run a fetch from your server to your remote repository
# and only update what's changed, but that requires some additional
# authentication between your server and the remote repository.
# I just want to get you up and running first.
# Worry about optimizing the process later.


# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do
    desc "Human readable description of task"
    task :name_of_task_command do
        # do stuff
    end
    
    desc "Symlink shared config files"
    task :symlink_config_files do
        run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
    end
    
    desc "Restart Passenger app"
    task :restart do
        run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
    end
end

namespace :customs do 
    task :symlink_db_yml do
        run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
    end
end

before 'bundle:install', 'customs:symlink_db_yml'

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
