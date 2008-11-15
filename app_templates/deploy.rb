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

namespace :rake do
  desc "Show the available rake tasks."
  task :show_tasks do
    run("cd #{deploy_to}/current; /usr/bin/rake -T")
  end
  task :db_create_sqlite do
    run("cd #{deploy_to}/current; /usr/bin/rake db:create")
  end
  task :db_schema_load_sqlite do
    run("cd #{deploy_to}/current; /usr/bin/rake db:schema:load")
  end
  task :db_create do
    run("cd #{deploy_to}/current; /usr/bin/rake db:create RAILS_ENV=production")
  end
  task :db_schema_load do
    run("cd #{deploy_to}/current; /usr/bin/rake db:schema:load RAILS_ENV=production")
  end
  task :db_migrate do
    run("cd #{deploy_to}/current; /usr/bin/rake db:migrate RAILS_ENV=production")
  end
end
