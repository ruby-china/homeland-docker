app_root = '/var/www/homeland'
pidfile "/var/www/pids/puma-backup.pid"
state_path "/var/www/pids/puma-backup.state"
bind 'unix:/var/www/pids/homeland-backup.sock'
daemonize false
port 7001
workers 1
threads (ENV["min_threads"] || 8), (ENV["max_threads"] || 8)
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
