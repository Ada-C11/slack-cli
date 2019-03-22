require_relative "user"
require_relative "channel"
require_relative "slack"
require "dotenv"
require "httparty"
require "table_print"
tp.set User, :username, :id
tp.set Channel, :channel_name, :id, :members, :topic
Dotenv.load

class Workspace
  attr_accessor :selected, :selected, :users, :channels

  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
  end

  def select_user(user_identifier)
    @users.each do |user|
      if user.username == user_identifier || user.id == user_identifier
        @selected = user
      end
    end
    if @selected == nil
      raise ArgumentError, "That user is invalid"
    else
      return @selected
    end
  end

  def select_channel(channel_identifier)
    @channels.each do |channel|
      if channel.channel_name == channel_identifier || channel.id == channel_identifier
        @selected = channel
      end
    end
    if @selected == nil
      raise ArgumentError, "That channel is invalid"
    else
      return @selected
    end
  end

  def show_details
    tp @selected
  end

  def self.send_message
    # do a post request taking selected user as parameter
  end
end
