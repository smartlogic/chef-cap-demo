#
# Cookbook Name:: annoyances
# Recipe:: rhel
#
# Copyright 2012, Opscode, Inc.
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

#delete any preexisting firewall rules
execute("iptables -F") { ignore_failure true }.run_action(:run)

#turn off SELinux
execute("setenforce 0") { ignore_failure true }.run_action(:run)

execute"rpm --nodeps -e httpd" do
  ignore_failure true
  not_if do
    node['recipes'].include?("apache2") ||
      node.run_state[:seen_recipes].include?("apache2")
  end
end

#remove any .bash_logout
file("/root/.bash_logout") { action :delete }
