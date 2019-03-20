require_relative "recipient"

module Slack
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji

    def initialize(slack_id, name, real_name, status_text, status_emoji)
      super(slack_id, name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    def self.list
      list = []

      response = self.get("https://slack.com/api/users.list")

      response["members"].each do |member|
        slack_id = member["id"]
        name = member["name"]
        real_name = member["real_name"]
        status_text = member["profile"]["status_text"]
        status_emoji = member["status_emoji"]

        list << Slack::User.new(slack_id, name, real_name, status_text, status_emoji)
      end

      return list
    end
  end
end
