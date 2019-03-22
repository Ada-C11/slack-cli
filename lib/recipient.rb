require "httparty"
require "dotenv"
Dotenv.load

BASE_URL = "https://slack.com/api/"
KEY = ENV["TOKEN"]

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.list
  end

  private

  # Endpoint is somthing like 'users.list' or 'channels.list'
  def self.get(endpoint)
    url = BASE_URL + endpoint
    params = {
      token: KEY,
    }

    response = HTTParty.get(url, query: params)
    if response["ok"] == false
      raise SlackApiError, "API call failed with reason #{response["error"]}"
    end

    return response
  end
end
