require "awesome_print"
require_relative "recipient"

module Slack  
  class User < Recipient
    BASE_URL = "https://slack.com/api/users.list"
    PARAMETER = {token: ENV["SLACK_API_TOKEN"]}

    attr_reader :real_name, :status_text

    def initialize(name, slack_id, real_name)
      super(name, slack_id)
       @real_name = real_name
    end

    def self.list
      user_data = self.get(BASE_URL, PARAMETER)
      user_data["members"].map do |user|
        self.new(user["id"], user["name"], user["profile"]["real_name"])
      end

    end

    def details
      super << "real_name"
    end
  end
end




