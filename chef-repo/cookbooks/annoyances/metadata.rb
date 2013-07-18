name             "annoyances"
maintainer       "Opscode, Inc."
maintainer_email "matt@opscode.com"
license          "Apache 2.0"
description      "Removes assorted operating system annoyances."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

%w{ ubuntu redhat }.each do |os|
  supports os
end
