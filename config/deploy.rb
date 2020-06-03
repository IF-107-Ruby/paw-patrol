set :application, 'roompassport'
set :repo_url, 'git@github.com:IF-107-Ruby/paw-patrol.git'

set :deploy_to, "/home/deploy/#{fetch :application}"
set :branch, 'capistrano-setup'

append :linked_dirs, 'log',
       'tmp/pids',
       'tmp/cache',
       'tmp/sockets',
       'vendor/bundle',
       '.bundle',
       'public/system',
       'public/uploads',
       'storage'

set :keep_releases, 5

set :sidekiq_role, :app
set :sidekiq_config, "#{current_path}/config/sidekiq.yml"
set :sidekiq_env, 'production'
set :init_system, :systemd
set :service_unit_name, 'sidekiq'

append :linked_files, 'config/database.yml'
