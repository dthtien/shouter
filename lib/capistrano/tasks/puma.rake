namespace :deploy do
  after :restart do
    desc 'Config puma'
    on roles :web do
      with current_path do
        execute "mv config/puma_example.rb config/puma.rb"
        execute 'pumactl -P /home/deploy/shouter/shared/pids/puma.pid restart'
      end
    end
  end
end
