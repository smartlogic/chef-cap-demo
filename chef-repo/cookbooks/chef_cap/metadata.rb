maintainer       "SmartLogic Solutions"
maintainer_email "dan@smartlogicsolutions.com"
license          "MIT"
description      "Installs/Configures a server for the chef_cap rails application"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
recipe            "chef_cap", "Sets up application user and includes chef_cap::ruby and chef_cap::database"
recipe            "chef_cap::ruby", "Configures ruby for the chef_cap user via rbenv"
recipe            "chef_cap::database", "Configures the chef_cap database"

depends 'rbenv'
depends 'postgresql'
depends 'database'
