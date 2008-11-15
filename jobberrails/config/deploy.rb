load 'deploy' if respond_to?(:namespace) # cap2 differentiator

set :repository, 'git://github.com/schof/spree.git'
set :scm, :git
set :deploy_via, :copy
set :copy_cache, true

set :application, 'spree' # Enter the app's name / directory name here
set :deploy_to, "/var/www/#{application}"
set :mongrel_port, '8006'
set :user, 'root'
set :use_sudo, false  # We are already root 

role :app, "railsapps.fiveruns.net"
role :web, "railsapps.fiveruns.net"
role :db,  "railsapps.fiveruns.net", :primary => true

before  'deploy:update_code', 'deploy:web:disable' 
after   'deploy:update_code', 'deploy:config_database'
after   'deploy:update_code', 'deploy:config_servers'

## Not sure if these are functioning/applicable
after   'deploy:restart', 'deploy:cleanup'
after   'deploy:restart', 'deploy:web:enable'

namespace :deploy do
  task :restart do
    begin run "/usr/bin/mongrel_rails stop -P #{shared_path}/log/mongrel.#{mongrel_port}.pid"; rescue; end; sleep 15;
    begin run "/usr/bin/mongrel_rails start -d -e production -p #{mongrel_port} -P log/mongrel.#{mongrel_port}.pid -c #{release_path} --user root --group root"; rescue; end; sleep 15;
  end
  task :config_database do
    put(File.read('config/database.yml'), "#{release_path}/config/database.yml", :mode => 0444)
    # For security consider uploading a production-only database.yml to your server and using this instead:
    # run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  task :config_servers do
    put(File.read('script/spin'), "#{release_path}/script/spin", :mode => 0444)
    run "chmod 755 #{release_path}/script/spin"
    put(File.read('./nginx.conf'), "/etc/nginx/sites-available/#{application}", :mode => 0444)
    run "ln -s /etc/nginx/sites-available/#{application} /etc/nginx/sites-enabled/#{application}"
  end
end

after "deploy:update_code", "localize:install_gems"
after "deploy:update_code", "localize:copy_shared_configurations"
after "deploy:update_code", "localize:merge_assets"

namespace :init do
  desc "create mysql db"
  task :create_database do
    #create the database on setup
    set :db_user, Capistrano::CLI.ui.ask("database user: ") unless defined?(:db_user)
    set :db_pass, Capistrano::CLI.password_prompt("database password: ") unless defined?(:db_pass)
    run "echo \"CREATE DATABASE #{application}_production\" | mysql -u #{db_user} --password=#{db_pass}"
  end
end

namespace :localize do
  desc "copy shared configurations to current"
  task :copy_shared_configurations, :roles => [:app] do
    %w[database.yml].each do |f|
      run "ln -nsf #{shared_path}/config/#{f} #{release_path}/config/#{f}"
    end
  end
  
  desc "installs / upgrades gem dependencies "
  task :install_gems, :roles => [:app] do
    sudo "date"
    run "cd #{release_path} && sudo rake RAILS_ENV=production gems:install"
  end
  
  desc "merge asset files"
  task :merge_assets, :roles => [:app] do
    sudo "date" 
    run "cd #{release_path} && sudo script/merge_assets"
  end

  task :merge_current_assets, :roles => [:app] do
    sudo "date" 
    run "cd #{current_path} && sudo script/merge_assets"
  end
  
end
