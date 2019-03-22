require "httparty"
require "dotenv"
require_relative "workspace"
require_relative "user"
require_relative "channel"

Dotenv.load

module SlackApi
  BASE_URL = "https://slack.com/api/chat.postMessage"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  class SlackApiError < StandardError; end

  def self.send_message(message, user)
    user_name = User.list.map do |user_list|
      user_list[0]
    end
    # array of all channel names
    channel_name = Channel.list.map do |channel|
      channel[0]
    end

    #### TODO: CHANGE VARIABLE NAME
    practice = []
    User.list.each do |user_name_list|
      if user_name_list[0] == user
        practice << user_name_list[2]
      end
    end

    test_workspace = Workspace.new
    if channel_name.include?(user)
      response = HTTParty.post(
        "#{BASE_URL}",
        headers: { "Content-Type" => "application/x-www-form-urlencoded" },
        body: {
          token: SLACK_TOKEN,
          text: message,
          channel: test_workspace.select_channel(user), #.select_user(chose_user)
          as_user: true,
        },
      )
    elsif user_name.include?(user)
      response = HTTParty.post(
        "#{BASE_URL}",
        headers: { "Content-Type" => "application/x-www-form-urlencoded" },
        body: {
          token: SLACK_TOKEN,
          text: message,
          channel: practice[0],
          as_user: true,
        },
      )
    else
      raise SlackApiError, "The input #{user} is not included in our channels."
    end

    if response["ok"]
      return true
    else
      raise SlackApiError, "Error when posting #{message} to #{user}, error: #{response["error"]}"
    end
  end
end
