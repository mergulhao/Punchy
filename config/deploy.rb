require 'bundler/capistrano'
set :whenever_command, "bundle exec whenever"
require 'whenever/capistrano'

set :domain, "punchy.mergulhao.info"
set :application, "punchy"
set :repository,  "git://github.com/mergulhao/Punchy.git"
set :scm, :git

set :user, "railsapps"
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{application}"

server domain, :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end