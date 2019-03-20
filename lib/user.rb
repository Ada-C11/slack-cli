require "HTTParty"
require "dotenv"
require "awesome_print"

module Slack
  class User
    USER_URL = "https://slack.com/api/users.list"

    class SlackError < StandardError; end

    Dotenv.load

    attr_reader :username, :real_name, :slack_id

    def initialize(username, real_name, slack_id)
      @username = username
      @real_name = real_name
      @slack_id = slack_id
    end # initialize

    def self.list_users
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }
      response = HTTParty.get(USER_URL, query: query_parameters)
      ENV["SLACK_API_TOKEN"]

      slack_users = {}
      if (response.code == 200)
        user_passes = response["members"].map do |user|
          slack_users[user] = { "slack_id" => user["id"],
                               "username" => user["name"],
                               "real name" => user["real_name"] }
        end
      else
        puts "Error #{response.code} : #{response["message"]}"
      end # else
    end

    ap self.list_users
  end # class
end # module
