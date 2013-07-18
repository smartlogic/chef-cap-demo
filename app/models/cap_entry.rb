class CapEntry < ActiveRecord::Base

  SINGLETON_MSG = "I am the singleton capistrano run message!"

  def self.recent_first
    order('created_at desc')
  end

  def self.singleton_entry
    where(:message => SINGLETON_MSG).first
  end
end
