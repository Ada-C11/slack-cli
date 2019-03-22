require_relative "recipient"
require "pry"
require "dotenv"
require "httparty"
require "table_print"

Dotenv.load

module Slack
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji

    def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
      super(slack_id, name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    BASE_URL = "https://slack.com/api/"
    USER_URL = "https://slack.com/api/users.list"

    def details
      return {
        name: @real_name,
        status: @status_text,
        emoji: @status_emoji,
        slack_id: @slack_id,
        username: @name
      }
    end

    def self.users_get
      query_params = { token: ENV["SLACK_API_TOKEN"] }
      return Slack::User.get(USER_URL, query_params)
    end

    def self.list
      response = Slack::User.users_get
      users = response["members"].map do |member|
        name = member["name"]
        slack_id = member["id"]
        real_name = member["real_name"]
        status_text = member["profile"]["status_text"]
        status_emoji = member["profile"]["status_emoji"]

        Slack::User.new(name: name, slack_id: slack_id, real_name: real_name, status_text: status_text, status_emoji: status_emoji)
      end

      return users
    end
  end
end
