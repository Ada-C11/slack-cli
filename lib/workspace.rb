require_relative "user"
require_relative "channel"
require_relative "slack"
require "dotenv"
require "httparty"
require "pry"
Dotenv.load

class Workspace
  attr_accessor :selected, :users, :channels

  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = selected
  end

  def select_user(user_identifier)
    selected_user = nil
    @users.each do |user|
      if user.username == user_identifier || user.id == user_identifier
        selected_user = user
      end
    end
    if selected_user == nil
      raise ArgumentError, "That user is invalid"
    else
      @selected = selected_user
      return @selected
    end
  end

  def select_channel(channel_identifier)
    selected_channel = nil
    @channels.each do |channel|
      if channel.channel_name == channel_identifier || channel.id == channel_identifier
        selected_channel = channel
      end
    end
    if selected_channel == nil
      raise ArgumentError, "That channel is invalid"
    else
      @selected = selected_channel
      return @selected
    end
  end

  def self.show_details
    #format details for selected user/channel w/ table gem
  end

  def self.send_message
    # do a post request taking selected user as parameter
  end
end
