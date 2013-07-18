Description
===========

Removes a number of operating system based annoyances. There are
recipes RHEL and Debian platform families.

Feel free to fork and submit your own patches.

Requirements
============

## Platform

Supports both `rhel` and `debian` platform families.

* Debian, Ubuntu
* Red Hat, CentOS, Scientific, Oracle, Amazon, Fedora

If your Chef/Ohai version aren't new enough for the
`node['platform_family']` attribute, then simply include the
platform-specific recipe.

Recipes
=======

default
-------

Looks at the node's `platform_family` and includes the proper recipe,
then removes `annoyances` from the node's run list on completion.

If the node's `platform_family` is not found, an exception will be
raised.

## rhel

Removes any preexisting firewall rules, turns off SELinux, uninstalls
httpd if it's on for some reason and removes /root/.bash_logout if it
exists.

If the `apache2` recipe is on the node, the httpd package will not be
removed.

## debian

Does an "apt-get update", turns off apparmor and turns off byobu.
Removes whoopsie, popularity-contest, and unity-lens-shopping if this
ever got on a server.

Usage
=====

Include the `annoyances` recipe in your run list and it will make the
various changes, then remove itself from the node's run list on
completion. If you want to keep enforcing the `annoyances` with each
run, directly include the operating system-specific recipe instead of
the `default` recipe.

License and Author
==================

Author:: Matt Ray (<matt@opscode.com>)
Author:: Joshua Timberman (<joshua@opscode.com>)

Copyright 2012 Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
