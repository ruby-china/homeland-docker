app_root = '/var/www/ruby-china'
pidfile "/var/www/pids/puma.pid"
state_path "/var/www/pids/puma.state"
stdout_redirect "/var/www/log/puma.stdout.log", "/var/www/log/puma.stderr.log", true
bind 'unix:/var/www/pids/ruby-china.sock'
daemonize false
port 7000
workers 4
threads 8, 16
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end