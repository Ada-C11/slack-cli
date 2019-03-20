require "pry"

require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
  end

  def select_channel(user_input)
    selected = channels.select do |channel|
      channel.name == user_input || channel.slack_id == user_input
    end
    return selected.first
  end

  def select_user(user_input)
    selected = users.select do |user|
      user.name == user_input || user.slack_id == user_input
    end
    return selected.first
  end

  def show_details
  end

  def print_details(recipients)
    if recipients == "users"
      users.each do |user|
        return user.details
      end
    elsif recipients == "channels"
      channels.each do |channel|
        return channel.details
      end
    end
  end

  def send_message
  end
end
