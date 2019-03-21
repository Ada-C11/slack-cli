require_relative "recipient"

module Slack
  class User < Recipient
    attr_reader :slack_id, :name, :real_name

    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
    end

    def self.get
      url = "https://slack.com/api/users.list"
      params = {
        token: ENV["KEY"],
      }

      response_from_get = HTTParty.get(url, query: params)

      return response_from_get
    end

    def self.list_all
      users = User.get["members"].map do |user|
        self.new(user["id"], user["name"], user["profile"]["real_name"])
      end
      return users
    end
  end
end
