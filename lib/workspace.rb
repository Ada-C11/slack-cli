require "httparty"
require "pry"
require_relative "user.rb"
require_relative "channel.rb"
require_relative "recipient.rb"

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

    if @selected == nil
      raise ArgumentError, "channel not found"
    else
      return @selected
    end
  end

  def select_user(user)
    @users.each do |x|
      if user.downcase == (x.name).downcase || user.downcase == (x.slack_id).downcase
        @selected = x
      end
    end

    if @selected == nil
      raise ArgumentError, "user not found"
    else
      return @selected
    end
  end

  def show_user_details(name)
    x = select_user(name)
    return "username: #{x.name} | real name: #{x.real_name} | Slack id: #{x.slack_id}"
  end

  def show_channel_details(name)
    x = select_channel(name)
    return "name: #{x.name} | topic: #{x.topic} | Slack id: #{x.slack_id}"
  end

  def send_msg_to_user(user, message)
    x = select_user(user)
    url = BASE_URL + "chat.postMessage"
    params = {
      token: KEY,
      channel: x.slack_id,
      text: message,
    }

    posted_message = HTTParty.post(url, query: params)
    if posted_message["ok"] == false
      raise SlackApiError, "API call failed with reason #{posted_message["error"]}"
    end

    return "You: #{posted_message["message"]["text"]}"
  end

  def send_msg_to_channel(channel, message)
    x = select_channel(channel)
    url = BASE_URL + "chat.postMessage"
    params = {
      token: KEY,
      channel: x.slack_id,
      text: message,
    }

    posted_message = HTTParty.post(url, query: params)
    if posted_message["ok"] == false
      raise SlackApiError, "API call failed with reason #{posted_message["error"]}"
    end

    return "You: #{posted_message["message"]["text"]}"
  end
end
