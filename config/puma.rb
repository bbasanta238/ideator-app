workers Integer(ENV["WEB_CONCURRENCY"] || 2)
threads_count = Integer(ENV["RAILS_MAX_THREADS"] || 5)
threads threads_count, threads_count

preload_app!

port ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "production" }

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
