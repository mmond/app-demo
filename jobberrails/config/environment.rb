# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

require 'github_gem'
Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_jobberrails_session',
    :secret      => 'f00a3b20e41452de05331d4fbc2b770232521accbb0e8e214eac6dcca55887b0083847a133b91e034f5f35c5eb8d6184fe3472fed701efb2c2c1b1cb7021770f'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  
  # Gem Requirements
  config.gem "haml", :version => ">= 2.0.0"
  
  # exception_notification
  # ------
  # Allows unhandled exceptions to be emailed on production
  # ------
  config.github_gem 'jcnetdev-exception_notification', :version => '>= 1.1'

  # acts_as_list
  # ------
  # Allows ActiveRecord Models to be easily ordered via position attributes
  # ------
  config.github_gem 'jcnetdev-acts_as_list', :version => '>= 1.0'
  
  # app_config
  # ------
  # Allow application wide configuration settings via YML files
  # ------
  config.github_gem 'jcnetdev-app_config', :version => '>= 1.0'
  
  # auto_migrations
  # ------
  # Allows migrations to be run automatically based on updating the schema.rb
  # ------
  config.github_gem 'jcnetdev-auto_migrations', :version => '>= 1.2'

  # better_partials
  # ------
  # Adds a helper (partial) that wraps around render :partial. Pass local variables and blocks to your partials easily
  # ------
  config.github_gem 'jcnetdev-better_partials', :version => '>= 1.0'
  
  # form_fu
  # ------
  # Allows easier rails form creation and processing
  # ------
  config.github_gem 'neorails-form_fu', :version => '>= 0.51'
                                       
  # paperclip
  # ------
  # Allows easy uploading of files
  # ------
  config.github_gem 'jcnetdev-paperclip', :version => '>= 1.0'

  # seed-fu
  # ------
  # Allows easier database seeding of tables
  # ------
  config.github_gem 'jcnetdev-seed-fu', :version => '>= 1.0'

  # subdomain-fu
  # ------
  # Allows easier subdomain selection
  # ------
  # config.github_gem 'jcnetdev-subdomain-fu', :version => '>= 0.0.2'
  
  # validates_as_email_address
  # ------
  # Allows for easy format validation of email addresses
  # ------
  config.github_gem 'jcnetdev-validates_as_email_address', :version => '>= 1.0'
  
  # will_paginate
  # ------
  # Allows nice and easy pagination
  # ------
  config.github_gem 'jcnetdev-will_paginate', :version => '>= 2.3.2'
  
  # view_fu
  # ------
  # Adds view helpers for titles, stylesheets, javascripts, and common tags
  # ------
  config.github_gem 'neorails-view_fu', :version => '>= 0.3'
  
end

