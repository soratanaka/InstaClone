# config valid only for current version of Capistrano
lock '3.16.0'

# デプロイするアプリケーション名
set :application, 'InstaClone'

# cloneするgitのレポジトリ
# （xxxxxxxx：ユーザ名、yyyyyyyy：アプリケーション名）
set :repo_url, 'git@github.com:soratanaka/InstaClone.git'

# deployするブランチ。デフォルトでmainを使用している場合、masterをmainに変更してください。
set :branch, ENV['BRANCH'] || 'master'

# deploy先のディレクトリ。
set :deploy_to, '/var/www/InstaClone'

# シンボリックリンクをはるフォルダ・ファイル
set :linked_files, %w{.env config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

# Rubyのバージョン
set :rbenv_ruby, '3.0.1'
set :rbenv_type, :system

# 出力するログのレベル。エラーログを詳細に見たい場合は :debug に設定する。
# 本番環境用のものであれば、 :info程度が普通。
# ただし挙動をしっかり確認したいのであれば :debug に設定する。
set :log_level, :info

# master.key用のシンボリックリンクを追加
set :linked_files, %w{ config/master.key }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'upload master.key'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
        upload!('config/master.key', "#{shared_path}/config/master.key")
      end
    end
    before :starting, 'deploy:upload'
    after :finishing, 'deploy:cleanup'
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after 'deploy:publishing', 'deploy:restart'
    namespace :deploy do
    task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

end