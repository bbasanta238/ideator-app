# ... (keep the existing settings)

# Add this at the top of your file, after the requires
require "sshkit/sudo"
lock "~> 3.19.1"

set :application, "ideator"
set :repo_url, "git@github.com:bbasanta238/ideator.git"
set :deploy_to, "/var/www/ideator"
set :rbenv_type, :user
set :rbenv_ruby, "3.1.2"
set :user, "ubuntu"
set :use_sudo, true
set :branch, "main"
set :linked_files, %w{config/database.yml config/master.key}
set :rails_env, "production"
set :keep_releases, 2
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")

# ... (keep other existing settings)

# Override the default deploy:check:directories task
namespace :deploy do
  namespace :check do
    task :directories do
      on roles(:all) do |host|
        path = shared_path
        sudo :mkdir, "-pv", path
        sudo :chown, "#{host.user}:#{host.user}", path
        path = releases_path
        sudo :mkdir, "-pv", path
        sudo :chown, "#{host.user}:#{host.user}", path
      end
    end
  end
end

namespace :deploy do
  desc "Create necessary directories"
  task :create_directories do
    on roles(:app) do |host|
      path = fetch(:deploy_to)
      sudo :mkdir, "-pv", path
      sudo :chown, "-R", "#{host.user}:#{host.user}", path
    end
  end

  before "deploy:check:directories", :create_directories
end

namespace :puma do
  desc "Create Directories for Puma Pids and Socket"
  task :make_dirs do
    on roles(:app) do |host|
      path = "#{shared_path}/tmp/sockets"
      sudo :mkdir, "-pv", path
      sudo :chown, "-R", "#{host.user}:#{host.user}", path
      path = "#{shared_path}/tmp/pids"
      sudo :mkdir, "-pv", path
      sudo :chown, "-R", "#{host.user}:#{host.user}", path
    end
  end
  before :start, :make_dirs
end

# Add this at the end of your file
set :pty, true
