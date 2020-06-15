set :application, 'roompassport'
set :repo_url, 'git@github.com:IF-107-Ruby/paw-patrol.git'

set :deploy_to, "/home/deploy/#{fetch :application}"
set :branch, 'master'

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

namespace :telegram_bot do
  desc 'Stop telegram bot'
  task :stop do
    on roles(:app) do
      execute :systemctl, '--user', 'stop', 'telegram_bot'
    end
  end

  desc 'Start telegram bot'
  task :start do
    on roles(:app) do
      execute :systemctl, '--user', 'start', 'telegram_bot'
    end
  end

  desc 'Restart telegram bot'
  task :restart do
    invoke 'telegram_bot:stop'
    invoke 'telegram_bot:start'
  end
end

after 'deploy:publishing', 'telegram_bot:restart'
