#
# Cookbook Name:: chef_cap
# Recipe:: default
#
# Copyright 2012, SmartLogic Solutions
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

user(node['chef_cap']['web_user']) do
  home      "/home/#{node['chef_cap']['web_user']}"
  shell     "/bin/bash"
  supports  :manage_home => true
end

directory "/home/#{node['chef_cap']['web_user']}/.ssh" do
  action :create
  owner  node['chef_cap']['web_user']
  group  node['chef_cap']['web_user']
  mode   '0700'
end

template "/home/#{node['chef_cap']['web_user']}/.ssh/authorized_keys" do
  source 'authorized_keys.erb'
  owner  node['chef_cap']['web_user']
  group  node['chef_cap']['web_user']
  mode  '0600'
  variables :keys => data_bag_item('users', 'deploy')["ssh_keys"]
end

include_recipe "chef_cap::ruby"

include_recipe "chef_cap::database"

