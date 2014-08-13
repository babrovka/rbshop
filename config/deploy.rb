# -*- encoding : utf-8 -*-
set :ruby_version, '2.1.2'
set :application, 'rbshop'
set :user, "babrovka"
set :serv, "109.120.165.36"
set :port, 34511

set :repository,  'git@github.com:babrovka/rbshop.git'
set :branch, 'dev'
set :server_name, 'test.rbcos.ru'
set :server_redirect, 'www.test.rbcos.ru'

set :backup_db, false
set :backup_sys, false

set :deploy_to, "/home/#{user}/projects/#{application}"

set :keep_releases, 5
set :use_sudo, false

set :scm, :git

role :app, serv
role :web, serv
role :db, serv, :primary => true
