
require "awesome_print"
require "dotenv"
Dotenv.load
require_relative "user"

module SlackCLI
  class Workspace
    attr_reader :users, :channels
    USER_URL = "https://slack.com/api/users.list"
    KEY = ENV["SLACK_API_TOKEN"]

    def initialize
      @users = []
      @channels = channels
    end

    def users_list
      @users = SlackCLI::User.list(USER_URL, KEY)
      return @users
    end
  end
end
