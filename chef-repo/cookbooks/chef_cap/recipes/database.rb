include_recipe "postgresql::ruby"

directory "#{node['chef_cap']['cap_base']}" do
  action :create
  owner  node['chef_cap']['web_user']
  group  node['chef_cap']['web_user']
  mode '0755'
end

directory "#{node['chef_cap']['deploy_to']}" do
  action :create
  owner  node['chef_cap']['web_user']
  group  node['chef_cap']['web_user']
  mode '0755'
end

directory "#{node['chef_cap']['deploy_to']}/shared" do
  action :create
  owner  node['chef_cap']['web_user']
  group  node['chef_cap']['web_user']
  mode '0755'
end

template "#{node['chef_cap']['deploy_to']}/shared/database.yml" do
  source 'database.yml.erb'
  owner  node['chef_cap']['web_user']
  group  node['chef_cap']['web_user']
  mode '0644'
end


postgresql_database node['chef_cap']['database'] do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :create
end

postgresql_database "create chef table" do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :query
  database_name node['chef_cap']['database']
  sql "CREATE TABLE IF NOT EXISTS chef_entries ( message text, created_at timestamp )"
end

postgresql_database "insert singleton chef table row" do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :query
  database_name node['chef_cap']['database']
  sql "INSERT INTO chef_entries (message, created_at) values ('I am the singleton chef run message!', CURRENT_TIMESTAMP)"
  not_if %Q{psql #{node['chef_cap']['database']} -c "SELECT * FROM chef_entries where message like '%singleton%'" | grep singleton}, :user => :postgres
end

postgresql_database "insert chef run chef table row" do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :query
  database_name node['chef_cap']['database']
  sql "INSERT INTO chef_entries (message, created_at) values ('I was created by a chef run!', CURRENT_TIMESTAMP)"
end

