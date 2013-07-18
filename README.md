# Intoduction

This project provides an example of setting up a server with [Chef](http://www.opscode.com/chef/)
and deploying a [Ruby on Rails](http://rubyonrails.org/) application do it with [Capistrano](https://github.com/capistrano/capistrano)

# Getting Started

1. Install [VirtualBox](https://www.virtualbox.org/)
1. Install [Vagrant](http://www.vagrantup.com/)
1. `git clone git@github.com:smartlogic/chef-cap-demo.git`
1. `cd chef-cap-demo`
1. `bundle install`
1. `vagrant up`
1. `vagrant ssh-config --host chef_cap_demo >> ~/.ssh/config`

# Chef

1. `cd chef-repo`
1. `bundle install`

Vagrant boxes already have chef installed, but lets install with our own bootstrap
file to provide a good example for when you aren't using Vagrant.
See `chef-repo/.chef/bootstrap/precise32_vagrant.erb` to see how Chef gets installed

1. `bundle exec knife bootstrap -p 2222 -x vagrant -d precise32_vagrant chef_cap_demo`
1. `bundle exec knife cook vagrant@chef_cap_demo`

Check to see if you can login as the deploy user

`ssh -l deploy chef_cap_demo`

# Chef cookbook for the app

Create a chef cookbook for your application

1. `git checkout app_cookbook`
1. `bundle exec knife cook vagrant@chef_cap_demo`

`ssh -l chefcapapp chef_cap_demo`

