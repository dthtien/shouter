# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, 'shouter'
set :repo_url, 'git@github.com:dthtien/shouter.git'
set :deploy_user, 'deploy'

set :deploy_to, "/home/#{fetch :deploy_user}/#{fetch :application}"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secureaftet
after 'deploy', 'puma:config'
# after 'deploy', 'nginx:restart'
after 'deploy', 'sidekiq:restart'
after 'deploy', 'elastic_search:reindex'

namespace :puma do
  desc 'Config puma'
  task :config do
    on roles :web do
      execute "mv #{current_path}/config/puma_example.rb #{current_path}/config/puma.rb"
      within current_path do
        execute :bundle, :exec, 'pumactl -P /home/deploy/shouter/shared/pids/puma.pid restart'
      end
    end
  end
end

namespace :nginx do
  task :restart do
    on roles :all do
      execute "service nginx restart"
    end
  end
end

namespace :sidekiq do
  task :restart do
    on roles :web do
      within current_path do
        execute :bundle, :exec, 'sidekiqctl stop tmp/pids/sidekiq.pid 0'
        execute :bundle, :exec, 'sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e production -P tmp/pids/sidekiq.pid'
      end
    end
  end
end

namespace :elastic_search do
  task :reindex do
    on roles :web do
      within current_path do
        execute :rake, 'db:reindex'
      end
    end
  end
end
