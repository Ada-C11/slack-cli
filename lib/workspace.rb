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
    @channels.each do |x|
      if channel.downcase == (x.name).downcase || channel.downcase == (x.slack_id).downcase
        @selected = x
      end
    end
    return @selected
  end
  
  def select_user(user)
    @users.each do |x|
      if user.downcase == (x.name).downcase || user.downcase == (x.slack_id).downcase
        @selected = x
      end
    end
    return @selected
  end
  
  def show_details
  end
  
  def send_message
  end
end

