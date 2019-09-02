threads_count = ENV.fetch('MAX_THREADS') { 5 }.to_i
threads threads_count, threads_count

if ENV['SOCKET']
  bind "unix://#{ENV['SOCKET']}"
else
  bind "tcp://#{ENV.fetch('BIND', '127.0.0.1')}:#{ENV.fetch('PORT', 3000)}"
end

environment ENV.fetch('RAILS_ENV') { 'development' }
workers     ENV.fetch('WEB_CONCURRENCY') { 2 }

name = ENV.fetch('NAME') { 'puma' }
daemonize true
state_path "tmp/pids/#{name}.state"
pidfile "tmp/pids/#{name}.pid"
stdout_redirect "log/#{name}.stdout.log", "log/#{name}.stderr.log", true

preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

plugin :tmp_restart
