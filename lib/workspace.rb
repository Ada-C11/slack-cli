require "pry"
require "json"

require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
  end

  def select_channel(user_input)
    selected = channels.select do |channel|
      channel.name == user_input || channel.slack_id == user_input
    end
    @selected = selected.first
  end

  def select_user(user_input)
    selected = users.select do |user|
      user.name == user_input || user.slack_id == user_input
    end
    @selected = selected.first
  end

  def show_details
    return @selected.details
  end

  def print_details(recipients)
    if recipients == "users"
      return_array = []
      users.each do |user|
        return_array << user.details
      end
    elsif recipients == "channels"
      return_array = []
      channels.each do |channel|
        return_array << channel.details
      end
    end
    return return_array
  end

  def update_settings(name, emoji)
    json_hash = { "username" => name,
                  "icon_emoji" => emoji }
  end

  def send_message(text)
    selected.send_msg(text, selected.slack_id)
  end
end

# binding.pry
