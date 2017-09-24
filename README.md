### setup
* vagrant up
* ssh-copy-id vagrant@localhost -p 2222 # passwd: vagrant
* BRANCH=master bundle exec cap stage deploy
* ssh vargrant@localhost -p 2222 "ps -ef | grep cron-job"
* tail -f log/* # check ./log/cron.log

### analytics
`execute "bash -l -c 'cd /home/vagrant/test-demo/current && (nohup rvm use 2.4.2 do ruby bin/cron_job 2>&1 &)"`, named `A`.
this will fail to create daemon process

`execute "bash -l -c 'cd /home/vagrant/test-demo/current && (nohup rvm use 2.4.2 do ruby bin/cron_job 2>&1 &) && sleep 2' "`, named `B`.
this will succeed to create daemon process

* ssh execute cmd `A`, ssh exit before nohup complete to create daemon process, so we can add a sleep for 2 seconds to prevent ssh from
exiting before nohup complete to spawn daemon process.

note: you should use `eye` to spawn daemon process and monitor them.
