#
# Cookbook Name:: users_solo
# Provider:: manage
#
# Copyright 2012, MR2 Tech
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def initialize(*args)
  super
  @action = :create
end

action :remove do
  users = data_bag("#{new_resource.data_bag}")
  users.each do |login|
    del_user = data_bag_item("#{new_resource.data_bag}", login)
    if del_user['groups'].include?("#{new_resource.search_group}") and del_user['action'] == 'remove'
      user(del_user['id']) do
        action :remove
      end
    end
  end
end

action :create do

  ruby_block "reset group list" do
      action :nothing
      block do
          Etc.endgrent
      end
  end

  security_group = Array.new
  users = data_bag("#{new_resource.data_bag}")
  users.each do |login|
    new_user = data_bag_item("#{new_resource.data_bag}", login)
    if new_user['groups'].include?("#{new_resource.search_group}") and new_user['action'] != 'remove'

      security_group << new_user['id']

      if node[:apache] and node[:apache][:allowed_openids]
        Array(new_user['openid']).compact.each do |oid|
          node[:apache][:allowed_openids] << oid unless node[:apache][:allowed_openids].include?(oid)
        end
      end

      # Set home to location in data bag,
      # or a reasonable default (/home/$user).
      if new_user['home']
        home_dir = new_user['home']
      else
        home_dir = "/home/#{new_user['id']}"
      end

      # The user block will fail if the group does not yet exist.
      # See the -g option limitations in man 8 useradd for an explanation.
      # This should correct that without breaking functionality.
      if new_user['gid'] and new_user['gid'].group_id.kind_of?(Numeric)
        group new_user['id'] do
          gid new_user['gid']
        end
      end

      # Create user object.
      # Do NOT try to manage null home directories.
      user(new_user['id']) do
        uid new_user['uid']
        if new_user['gid']
          gid new_user['gid']
        end
        shell new_user['shell']
        comment new_user['comment']
        if home_dir == "/dev/null"
          supports :manage_home => false
        else
          supports :manage_home => true
        end
        home home_dir
        notifies :create, resources(:ruby_block => "reset group list"), :immediately
      end

      if home_dir != "/dev/null"
        directory "#{home_dir}/.ssh" do
          owner new_user['id']
          group new_user['gid'] || new_user['id']
          mode "0700"
        end
        if new_user['ssh_keys']
          template "#{home_dir}/.ssh/authorized_keys" do
            source "authorized_keys.erb"
            owner new_user['id']
            group new_user['gid'] || new_user['id']
            mode "0600"
            variables :ssh_keys => new_user['ssh_keys']
          end
        end
      end
    end
  end

  group "#{new_resource.group_name}" do
    group_name "#{new_resource.group_name}"
    gid new_resource.group_id
    members security_group
  end
end