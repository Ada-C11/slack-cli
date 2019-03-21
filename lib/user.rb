require "HTTParty"
require "dotenv"
require "awesome_print"

module Slack
  class User
    USER_URL = "https://slack.com/api/users.list"

    class SlackError < StandardError; end

    Dotenv.load

    # attr_reader :username, :real_name, :slack_id

    # def initialize(username, real_name, slack_id)
    #   @username = username
    #   @real_name = real_name
    #   @slack_id = slack_id
    # end # initialize

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
                               "realname" => user["real_name"] }
        end
      else
        raise Slack::SlackError, "There was an error. #{response.error}: #{response.message}"
      end # else
      return slack_users
    end # end

    def select_user(id)
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }
      response = HTTParty.get(USER_URL, query: query_parameters)

      chosen_one = ""
      response["members"].each do |member|
        if member["name"] == id
          chosen_one = id
        elsif member["real_name"] == id
          chosen_one = id
        end
      end # each

      if chosen_one == ""
        raise Slack::SlackError, "User must have an id or a name."
      end # end
      return chosen_one
    end # self.select_user

    # ap self.list_users
  end # class
end # module
