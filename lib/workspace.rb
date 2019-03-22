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
  attr_reader :selected, :users, :channels

  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
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

  def show_details
    if @selected == nil
      raise ArgumentError
    else
      return @selected
    end
  end

  def send_message(message)
    post_url = "https://slack.com/api/"
    token = ENV["SLACK_API_TOKEN"]
    response = HTTParty.post(
      "#{post_url}/chat.postMessage",
      body: {
        token: token,
        text: message,
        channel: @selected.id,
      },
      headers: {"Content-Type" => "application/x-www-form-urlencoded"},
    )
    if response["ok"]
      return response["ok"]
    else
      raise ArgumentError
    end
  end
end
