set :user, 'chefcapapp'
set :sudo_user, 'deploy'
server 'chef_cap_demo', :web, :app, :db, :primary => true
set :port, 2222

set :deploy_to, '/home/chefcapapp/apps/chef_cap'
set :rails_env, 'production'
