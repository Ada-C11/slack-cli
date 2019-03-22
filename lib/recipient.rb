require "dotenv"
require "httparty"
require "json"
Dotenv.load

class Recipient
  class SlackApiError < StandardError; end

  attr_accessor :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  CHANNEL_URL = "https://slack.com/api/channels.list"
  USER_URL = "https://slack.com/api/users.list"
  POST_URL = "https://slack.com/api/chat.postMessage"
  def self.get(type)
    params = {
      "token" => ENV["SLACK_API_TOKEN"],
    }
    if type == "user"
      url = USER_URL
    elsif type == "channel"
      url = CHANNEL_URL
    end

    response = HTTParty.get(url, query: params)
  end

  def send_msg(message, recipient)
    # settings = {}
    file = File.read("lib/bot-settings.json")
    settings = JSON.parse(file)
    params = {
      "token" => ENV["SLACK_API_TOKEN"],
      "channel" => recipient.slack_id,
      "text" => message,
      "username" => settings["username"],
      "icon_emoji" => settings["icon_emoji"],
    }
    if recipient.class == User
      params["as_user"] = true
    end

    response = HTTParty.post(
      POST_URL,
      body: params,
      headers: { "Content-Type" => "application/x-www-form-urlencoded" },
    )
    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "Error: #{response.parsed_response["error"]}"
    end
    return response
  end

  private

  def details
    raise NotImplementedError, "Implement this in the child class."
  end

  def self.list
    raise NotImplementedError, "Implement this in the child class."
  end
end
