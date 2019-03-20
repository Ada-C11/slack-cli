require "dotenv"
require "httparty"
Dotenv.load

class Recipient
  class SlackApiError < StandardError; end

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  CHANNEL_URL = "https://slack.com/api/channels.list"
  USER_URL = "https://slack.com/api/users.list"

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

  def send_message(message)
    response = HTTParty.post(url, message?)
  end

  private

  def details
    raise NotImplementedError, "Implement this in the child class."
  end

  def self.list
    raise NotImplementedError, "Implement this in the child class."
  end
end
