require "httparty"
require "dotenv"
Dotenv.load

class Recipient
  BASE_URL = "https://slack.com/api/chat.postMessage"
  TOKEN = ENV["SLACK_TOKEN"]

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
  end

  def self.get(url, params)
  end

  # def details - request details "package" from user or channel
  # def list - request list "package" from user or channel

end
