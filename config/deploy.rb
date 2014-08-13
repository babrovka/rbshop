require 'rvm/capistrano'
require 'bundler/capistrano'
load 'deploy/assets'

server "109.120.165.36", :web, :app, :db, primary: true

set :user, "babrovka"
set :application, "rbshop"
set :deploy_to, "/home/#{user}/projects/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :port, 34511
set :rvm_ruby_version, '2.1.2@rbshop'

set :scm, "git"
set :repository, "git@github.com:babrovka/#{application}.git"
set :branch, "dev"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true


task :copy_database_config do
   db_config = "#{shared_path}/database.yml"
   run "cp #{db_config} #{latest_release}/config/database.yml"
end

# namespace :deploy do
#   namespace :assets do
#     task :precompile, :roles => :web, :except => { :no_release => true } do
#       from = source.next_revision(current_revision)
#       if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
#         run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
#       else
#         logger.info "Skipping asset pre-compilation because there were no asset changes"
#       end
#     end
#   end
# end

namespace(:thin) do
  task :stop do
    run "thin stop -C /etc/thin/royal.yml"
   end
  
  task :start do
    run "thin start -C /etc/thin/royal.yml"
  end

  task :restart do
    run "thin restart -C /etc/thin/royal.yml"
  end
end


before "deploy:assets:precompile", "copy_database_config"
after "deploy", "deploy:cleanup"