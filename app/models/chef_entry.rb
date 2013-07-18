class ChefEntry < ActiveRecord::Base
  def self.recent_first
    order('created_at desc')
  end
end
