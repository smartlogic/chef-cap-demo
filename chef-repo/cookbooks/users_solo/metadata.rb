name             "users_solo"
maintainer       "MR2 Tech"
maintainer_email "rgaiser@mr2tech.com"
license          "Apache 2.0"
description      "Creates users from a databag using chef-solo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.2"

%w{ ubuntu debian redhat centos fedora freebsd}.each do |os|
  supports os
end
