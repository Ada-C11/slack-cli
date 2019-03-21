require "httparty"
require "dotenv"

Dotenv.load

module Slack
  class ResponseError < StandardError; end

  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url, params)
      user_data = HTTParty.get(url, query: params)

      if user_data["ok"] == false
        raise ResponseError, "There was an error!\nMessage: #{user_data["error"]}"
      end

      return user_data
    end

    def details
    end

    def send_message
    end

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end

# slack = Recipient.new
# slack.get("https://slack.com/api/channels.list", {token: ENV["KEY"]})

# puts slack
