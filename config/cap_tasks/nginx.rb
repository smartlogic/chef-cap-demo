namespace :nginx do
  desc "Setup nginx configuration for this application"
  task :setup, roles: :web do
    template "nginx_unicorn.erb", "/tmp/nginx_conf"
    with_sudo_user do
      sudo "mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
      sudo "rm -f /etc/nginx/sites-enabled/default"
      sudo "rm -f /etc/nginx/sites-enabled/000-default"
    end
    restart
  end
  after "deploy:setup", "nginx:setup"

  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command, roles: :web do
      with_sudo_user do
        sudo "service nginx #{command}"
      end
    end
  end
end
