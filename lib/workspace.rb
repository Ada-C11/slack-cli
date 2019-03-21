require 'httparty'
require_relative 'user.rb'
require_relative 'channel.rb'

class Workspace

  attr_reader :users, :channels, :selected
  
  def initialize 
    @users =[]
    @channels = []
    @selected
  end
  
  def select_channel(channel)
  end
  
  def select_user(user)
  end
  
  def show_details
  end
  
  def send_message
  end
end