require_relative "recipient"
require "awesome_print"

module Slack
  class User < Recipient
    attr_reader :real_name

    def initialize(real_name)
      super(slack_id, name)
      @real_name = real_name
      # @status_text
      # @status_emoji
    end

    def self.list(users_json)
      users_json["members"].map do |user|
        self.new(user["id"], user["name"], user["real_name"])
      end
    end
  end
end

ap Slack::User.get("https://slack.com/api/users.list", {token: ENV["KEY"]})
# puts Slack::User.list(potato)
