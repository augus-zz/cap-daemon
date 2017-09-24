server 'localhost', user: 'vagrant', roles: %w{cron}

set :deploy_to, '/home/vagrant/test-demo'
set :stage, :staging
set :branch, ENV['BRANCH'] || 'staging'
set :default_env, { RACK_ENV: 'staging' }

set :ssh_options, { forward_agent: false, port: 2222 }