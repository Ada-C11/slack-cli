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
  
  def show_details(recipient_type:, name:)
    if recipient_type.downcase == "channel"
      x = select_channel(name)
    elsif recipient_type.downcase == "user"
      x = select_user(name)
    else
      x = "User or channel not found"
    end
    return "username: #{x.name} | real name: #{x.real_name} | Slack id: #{x.slack_id}"
  end
  
  def send_message
  end
end

