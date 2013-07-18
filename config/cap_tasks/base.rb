def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to, :via => :scp
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def with_sudo_user(&block)
  with_user sudo_user do
    yield
  end
end

def with_user(new_user, &block)
  old_user = user
  set :user, new_user
  close_sessions
  yield
  set :user, old_user
  close_sessions
end

def close_sessions
  sessions.values.each { |session| session.close }
  sessions.clear
end
