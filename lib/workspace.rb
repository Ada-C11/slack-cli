require_relative "user"
require_relative "channel"
require_relative "slack"
require "dotenv"
require "httparty"
Dotenv.load

class Workspace
  attr_accessor :selected, :users, :channels

  def initialize
    @users = User.get
    @channels = Channel.get
    @selected = selected
  end

  def select_user(user)
    selected_user = @users["members"].select { |user_info| user_info["name"] == user }
    if selected_user.empty?
      raise ArgumentError, "That user is invalid"
    else
      @selected = selected_user
      return @selected
    end
  end

  def select_channel(channel)
    selected_channel = @channels["channels"].select { |channel_info| channel_info["name"] == channel }
    if selected_channel.empty?
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
