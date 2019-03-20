require "HTTParty"
require "pry"

require "dotenv"
Dotenv.load

class SlackError < StandardError; end

class Recipient

  # constants
  MSG_URL = "https://slack.com/api/chat.postMessage"
  LIST_URL = nil
  TOKEN = ENV["SLACK_TOKEN"]

  attr_reader :send_message, :name, :slack_id, :error_helper

  def initialize
    @slack_id = slack_id
    @name = name
  end

  def self.send_message(name:, message:)
    query_params = {
      token: TOKEN,
      channel: name,
      text: message,
    }
    response = HTTParty.post(MSG_URL, query: query_params)

    error_helper(response)
  end

  def self.get
    query_params = { 
      token: TOKEN 
    }
    response = HTTParty.get(LIST_URL, query: query_params)

    error_helper(response)
  end

  def self.error_helper(response)
    if response["ok"] != true
      raise SlackError, "#{response["error"]}"
    else
      return response
    end
  end

  def details
    raise NotImplementedError
  end

  def self.list
    raise NotImplementedError
  end
end
