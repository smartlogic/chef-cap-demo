class MessagesController < ApplicationController
  def index
    @chef_entries = ChefEntry.recent_first
    @capistrano_entries = CapEntry.recent_first
  end
end
