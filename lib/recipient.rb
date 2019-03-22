require "dotenv"
require "HTTParty"
require "pry"

Dotenv.load
KEY = ENV["SLACK_TOKEN"]
MESSAGE_URL = "https://slack.com/api/chat.postMessage"

module Slack
  class SlackApiError < StandardError; end

  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url, query:)
      response = HTTParty.get(url, query: query)
      if response["ok"] == false
        raise SlackApiError.new("Invalid request, error #{response.code}: #{response.message}")
      end

      return response
    end

    def send_message(message)
      body = {
        token: KEY,
        channel: slack_id,
        text: message,
      }
      response = HTTParty.post(MESSAGE_URL, body: body)

      if response["ok"] == false
        raise SlackApiError.new("Invalid request, error #{response.code}: #{response.message}")
      end

      return response
    end

    # private

    def self.list
      raise NotImplementedError, "implement in child class"
    end

    def details
      raise NotImplementedError, "implement in child class"
    end
  end
end
