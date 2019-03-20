require_relative "recipient"
require "awesome_print"

module Slack
  class User < Recipient
    URL = "https://slack.com/api/users.list"
    PARAM = {token: ENV["KEY"]}

    class ResponseError < StandardError; end

    attr_reader :real_name

    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
      # @slack_id = slack_id
      # @name = name
    end

    def self.list
      json_data = self.get(URL, PARAM)

      json_data["members"].map do |user|
        self.new(user["id"], user["name"], user["profile"]["real_name"])
      end
    end
  end
end

# ap Slack::User.get("https://slack.com/api/users.list", {token: ENV["KEY"]})
# # puts Slack::User.list(potato)
