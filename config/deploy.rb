# config valid only for current version of Capistrano
lock "3.9.1"

set :application, 'TestDemo'
set :repo_url, "http://github.com/zouqilin/cap-daemon"

set :pty, true
set :log_level, :info

set :linked_dirs, %w{log tmp/pids}
set :keep_releases, 20
set :bundle_jobs, 4

namespace :deploy do
  task :restart_cron do
    on roles(:cron) do
      execute "/bin/bash -l -c 'cd /home/vagrant/test-demo/current && (nohup rvm use 2.2.4 do ruby ./bin/cron_job >/dev/null 2>&1 &)'"
    end
  end

  after "deploy:published", "restart_cron"
end

