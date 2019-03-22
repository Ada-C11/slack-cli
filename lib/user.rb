require "HTTParty"
require "dotenv"
require "awesome_print"

module Slack
  class User
    USER_URL = "https://slack.com/api/users.list"

    class SlackError < StandardError; end

    Dotenv.load

    attr_reader :username, :real_name, :slack_id

    def initialize(username:, real_name:, slack_id:)
      @username = username
      @real_name = real_name
      @slack_id = slack_id
    end # initialize

    def self.get_user_data
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(USER_URL, query: query_parameters)

      if response.code == 200
        user_data = response["members"].map do |user|
          { username: user["name"],
           real_name: user["real_name"],
           slack_id: user["id"] }
        end
        return user_data
      else
        raise Slack::SlackError, "There was an error. #{response.error}: #{response.message}"
      end # if
    end

    # ap self.get_user_data

    def self.list_users
      users = get_user_data

      return users
    end

    # ap self.list_users

    def self.select_user(name_or_id)
      user_data = get_user_data
      chosen_user = nil

      user_data.each do |user|
        if user[:username] == name_or_id
          chosen_user = Slack::User.new(
            username: user[:username],
            real_name: user[:real_name],
            slack_id: user[:slack_id],
          )
        elsif user[:real_name] == name_or_id
          chosen_user = Slack::User.new(
            username: user[:username],
            real_name: user[:real_name],
            slack_id: user[:slack_id],
          )
        end
      end

      if chosen_user == nil
        raise Slack::SlackError, "There was an error. #{response.error}: #{response.message}"
      end

      return chosen_user
    end


    def show_details(name_or_id)
      user_details = User.select_user(name_or_id)

      details = {
        "Username" => user_details.username,
        "Real Name" => user_details.real_name,
        "Slack ID" => user_details.slack_id
      }
      return details
    end
  end # class
end # module
