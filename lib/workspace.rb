    
require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI
  class Workspace
    attr_reader :users, :channels
    USER_URL = "https://slack.com/api/users.list".freeze
    KEY = ENV["SLACK_API_TOKEN"]

    def initialize
      @users = SlackCLI::User.list(USER_URL, KEY)
      @channels = SlackCLI::User.list(USER_URL, KEY)
    end

    def self.users_details(user)
      details = SlackCLI::User.details(user, USER_URL, KEY)
      details
    end

    def self.user_message(text, user)
      message = SlackCLI::User.message(text, user)
    end

    def self.channel_details(_user)
      details = SlackCLI::Channel.details(KEY)
      details
    end
    end
  end
