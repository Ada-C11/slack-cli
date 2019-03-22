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
  attr_accessor :selected, :users, :channels

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
    return response.code == 200 && response.parsed_response["ok"]
  end
end
