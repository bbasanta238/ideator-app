lock "~> 3.19.1"

set :application, "ideator"
set :repo_url, "git@github.com:bbasanta238/ideator.git"
set :deploy_to, "/home/ubuntu/ideator"
set :rbenv_type, :user
set :rbenv_ruby, "3.1.2"
set :user, "ubuntu"
set :use_sudo, true
set :branch, "main"
set :linked_files, %w{config/database.yml config/master.key}
set :rails_env, "production"
set :keep_releases, 2
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
namespace :puma do
  desc "Create Directories for Puma Pids and Socket"
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end
