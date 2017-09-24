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
      within "/home/vagrant/test-demo/current" do
        execute "ps aux|grep cron_job|awk '{print $2}'|xargs kill -9"
        execute "ps aux|grep ping|awk '{print $2}'|xargs kill -9"
        execute "bash -l -c 'rvm use 2.4.2 do ruby --version'"
        execute "bash -l -c '(nohup rvm use 2.4.2 do ruby bin/cron_job 2>&1 &) && sleep 2' "
        execute "(nohup ping -i 2 www.baidu.com >> /vagrant/log/cron.log 2>&1 &) && sleep 2"
      end
    end
  end

  after "deploy:published", "restart_cron"
end