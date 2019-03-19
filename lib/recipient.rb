require "HTTParty"
require "pry"

require "dotenv"
Dotenv.load

class SlackError < StandardError; end

class Recipient

  # constants
  MSG_URL = "https://slack.com/api/chat.postMessage"
  USER_URL = "https://slack.com/api/users.list" # Move to User
  CHANNEL_URL = "https://slack.com/api/channels.list" #move to Channel

  attr_reader :send_message, :name, :slack_id

  def initialize
    @slack_id = slack_id
    @name = name
  end

  def self.send_message(name:, message:)
    query_params = {
      token: ENV["SLACK_TOKEN"],
      channel: name,
      text: message,
    }
    response = HTTParty.post(MSG_URL, query: query_params)

    if response["ok"] != true
      raise SlackError, "#{response["error"]}"
    else
      return response
    end
  end

  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    return response
  end
end
