require_relative "recipient"
require 'dotenv'
Dotenv.load

module SlackCLI
  class User < Recipient
    attr_reader :real_name

    def initialize(slack_id:, name:, real_name:)
      super(slack_id: slack_id, name: name)

      @real_name = real_name
    end

    def self.list
      url =	"https://slack.com/api/users.list"
      data = {
        "token": ENV["SLACK_API_TOKEN"]
      }
      response = self.get(url, data)
      users = []
      response["members"].each do |member|
        slack_id = member["id"]
        name = member["name"]
        real_name = member["real_name"]
        user = self.new(slack_id: slack_id, name: name, real_name: real_name)
        users << user
      end
      return users
    end
  end
end
