require "pry"

require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list
    @channels = Channel.list
    # @selected = selected
  end

  def select_channel
  end

  def select_user(user_input)
    selected_user = users.select do |user|
      user.name == user_input || user.slack_id == user_input
    end
    return selected_user.first
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
