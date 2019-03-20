require_relative "recipient"

module Slack
  class User < Recipient
    URL = "https://slack.com/api/users.list"
    PARAM = {token: ENV["KEY"]}

    attr_reader :real_name

    puts 'ENV["KEY2"]', ENV["KEY"]

    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
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
