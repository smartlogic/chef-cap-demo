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
