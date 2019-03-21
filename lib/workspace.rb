require 'httparty'
require 'pry'
require_relative 'user.rb'
require_relative 'channel.rb'
require_relative 'recipient.rb'

class Workspace

  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
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
