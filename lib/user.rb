require 'pry'

require_relative 'recipient'

module SlackCli
  class User < Recipient 
    LIST_URL = "https://slack.com/api/users.list"
    TOKEN = ENV["SLACK_TOKEN"]

    attr_reader :real_name, :status_text, :status_emoji, :list_users, :details

    def initialize(name, slack_id, real_name, status_text, status_emoji)
      @name = name
      @slack_id = slack_id
      @real_name = real_name
      @status_text = status_text 
      @status_emoji = status_emoji
    end

    def self.list
      response = SlackCli::User.get

      users = response["members"].map do |user|
        name = user["name"]
        slack_id = user["id"]
        real_name = user["profile"]["real_name"]
        status_text = user["profile"]["status_text"]
        status_emoji = user["profile"]["status_emoji"]
        self.new(name, slack_id, real_name, status_text, status_emoji)
      end

      return users
    end

    def self.list_users
      user_list = list.map do |user|
        user.name
      end
      return user_list
    end

    def self.details
      user_details = "Username: #{name}
        Slack ID: #{slack_id}
        Real Name: #{real_name}
        Status Text: #{status_text}
        Status Emoji: #{status_emoji}"
      return user_details
    end
  end
end