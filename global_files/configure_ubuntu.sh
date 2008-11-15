#!/bin/bash

#   This script will connect to your Ubuntu 8.0.4 server, install all the necessary applications and 
#   libraries to serve production Ruby on Rails applications and deploy the Eldorado full stack community.  
#	The script and its related configuration files are an extension are a superset of the original, 
#	basic configuration script for a new Slicehost Ubuntu server. 
#	
#	The previous script is available at: http://github.com/mmond.  It installed:
#		Ruby 1.8.6 
#		Rubygems 1.2
#		Rails 2.1.0
#		Sqlite3
#		MySQL 5.0.51a
#		Thin 0.8.2
#		Hello World example Rails application
#  	
#	This version of script includes the above and:
#		nginx
#		Capistrano
#		Mongrel
#		Eldorado full stack community web application  
#	

echo "Please enter the remote server IP address or hostname"
read -e TARGET_SERVER

#	Make first remote ssh connection
ssh root@$TARGET_SERVER '

#	Add alias for ll	(Dear Ubuntu: This should be default)
echo "alias \"ll=ls -lAgh\"" >> /root/.profile

#    Update Ubuntu package manager
apt-get update
apt-get upgrade -y

#   Install dependencies
apt-get -y install build-essential libssl-dev libreadline5-dev zlib1g-dev 

#	Install misc helpful apps
apt-get -y install git-core locate telnet elinks unzip

#	Install servers
apt-get -y install libsqlite-dev libsqlite3-ruby libsqlite3-dev 
apt-get -y install mysql-server libmysqlclient15-dev mysql-client 
apt-get -y install nginx

#    Install Ruby 
apt-get -y install ruby ruby1.8-dev irb ri rdoc libopenssl-ruby1.8 

#    Install rubygems v.1.3 from source.  apt-get installs
#    version 0.9.4 requiring a lengthy rubygems update
RUBYGEMS="rubygems-1.3.0"
wget http://rubyforge.org/frs/download.php/43985/$RUBYGEMS.tgz
tar xzf $RUBYGEMS.tgz
cd $RUBYGEMS
ruby setup.rb
cd ..
ln -s /usr/bin/gem1.8 /usr/bin/gem

#    Install gems
gem install -v=2.1.0 rails --no-rdoc --no-ri  
gem install -v=2.0.2 rails --no-rdoc --no-ri  
gem install mysql mongrel tzinfo thin --no-rdoc --no-ri
'
