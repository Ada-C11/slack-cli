    
require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI
  class Workspace
    attr_reader :users, :channels
    USER_API = "https://slack.com/api/users.list".freeze
    CHANNEL_API = "https://slack.com/api/channels.list"
    KEY = ENV["SLACK_API_TOKEN"]

    def initialize
      @users = SlackCLI::User.list(USER_API, KEY)
      @channels = SlackCLI::User.list(CHANNEL_API, KEY)
    end

    def self.users_details(user)
      SlackCLI::User.details(user, USER_API, KEY)
    end

    def self.user_message(text, user)
      SlackCLI::User.message(text, user)
    end

    def self.channel_details(user)
      SlackCLI::Channel.details(KEY)
    end
    end
  end
