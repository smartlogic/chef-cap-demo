Description
===========

Creates users from a databag.

Requirements
============

Platform
--------

* Debian, Ubuntu
* CentOS, Red Hat, Fedora
* FreeBSD

A data bag populated with user objects must exist.  The default data bag in this recipe is "users".  See USAGE.

Usage
=====

This cookbook is specific for setting up sysadmin group and users for now.

    include_recipe "users_solo::admins"

Use knife to create a data bag for users.

    knife data bag create users

Create a user.

    knife data bag users bofh
	{
	  "id": "rgaiser",
	  "ssh_keys": ["ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA..."],
	  "groups": ["admin"],
	  "uid": 2001,
	  "shell": "\/bin\/bash",
	  "comment": "Roberto Gaiser" 
	}

Remove a user, rgaiser.

    knife data bag users bofh
	{
	  "id": "rgaiser",
	  "ssh_keys": ["ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA..."],
	  "groups": ["admin"],
	  "uid": 2001,
	  "shell": "\/bin\/bash",
	  "comment": "Roberto Gaiser",
	  "action": "remove"
	}

    * Note only user bags with the "action : remove" and a search-able "group" attribute will be purged by the :remove action.

The default recipe makes use of the "users_manage" Lightweight Resource Provider (LWRP), and looks like this:


```
  users_manage "admin" do
    group_id 2600
    action [ :remove, :create ]
  end
```

Note this LWRP searches the "users" data bag for the "admin" group attribute, and adds those users to a Unix security group "admin".  The only required attribute is group_id, which represents the numeric Unix gid and *must* be unique.  The default action for the LWRP is ":create" only.

If you have different requirements, for example:

 * You want to search a different data bag specific to a role such as mail.  You may change the data_bag searched.
   - data_bag "mail"
 * You want to search for a different group attribute named "postmaster".  You may change the search_group attribute.  This attribute defaults to the LWRP resource name.
   - search_group "postmaster"
 * You want to add the users to a security group other than the lightweight resource name.  You may change the group_name attribute.  This attribute also defaults to the LWRP resource name.
   - group_name "wheel"
 * Users can have a pre configured numeric GID set on the data bag, otherwise a group with the user login will be created.

Putting these requirements together our recipe might look like this:

```
  users_manage "postmaster" do
    data_bag "mail"
    group_name "wheel"
    group_id 10
  end
```

The latest version of knife supports reading data bags from a file and automatically looks in a directory called +data_bags+ in the current directory. The "bag" should be a directory with JSON files of each item. For the above:

    mkdir data_bags/users
    $EDITOR data_bags/users/bofh.json

Paste the user's public SSH key into the ssh_keys value. Also make sure the uid is unique, and if you're not using bash, that the shell is installed. The default search, and Unix group is sysadmin.

The recipe, by default, will also create the admin group.

The admin group will be created with GID 2600. This may become an attribute at a later date.

The Apache cookbook can set up authentication using OpenIDs, which is set up using the openid key here. See the Opscode 'apache2' cookbook for more information about this.

License and Author
==================

Author:: Roberto Gaiser (<rgaiser@mr2tech.com>)

Copyright:: 2012, MR2 Tech


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
