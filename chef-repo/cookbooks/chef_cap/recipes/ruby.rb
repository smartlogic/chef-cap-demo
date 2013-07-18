include_recipe "rbenv"
include_recipe "rbenv::ruby_build"

rbenv_ruby node['chef_cap']['ruby_version']

rbenv_gem "bundler" do
  ruby_version node['chef_cap']['ruby_version']
end

