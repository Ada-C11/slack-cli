require "dotenv"
require "HTTParty"
require "pry"

require_relative "recipient"

Dotenv.load

module Slack
  class User < Recipient
    USER_URL = "https://slack.com/api/users.list"
    @query = { token: KEY }

    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji

    def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
      @slack_id = slack_id
      @name = name
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    def self.list
      response = self.get(USER_URL, query: @query)
      users = response["members"].map do |user|
        id = user["id"]
        name = user["name"]
        real_name = user["real_name"]
        status_text = user["profile"]["status_text"]
        status_emoji = user["profile"]["status_emoji"]
        self.new(slack_id: id, name: name, real_name: real_name, status_text: status_text, status_emoji: status_emoji)
      end
      return users
    end

    def details
      return "slack_id: #{slack_id}, name: #{name}, real_name: #{real_name}, status_text: #{status_text}, status_emoji: #{status_emoji}"
    end
  end
end
