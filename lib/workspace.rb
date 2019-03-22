require_relative "channel"
require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI
  class Workspace
    attr_reader :users, :channels
    USER_API = "https://slack.com/api/users.list".freeze
    CHANNEL_API = "https://slack.com/api/channels.list".freeze
    KEY = ENV["SLACK_API_TOKEN"]

    def initialize
      @users = SlackCLI::User.list(USER_API, KEY)
      @channels = SlackCLI::Channel.list(CHANNEL_API, KEY)
    end

    def self.users_details(user)
      SlackCLI::User.details(user, USER_API, KEY)
    end

    def self.user_message(text, user)
      SlackCLI::User.message(text, user)
    end

    def self.channel_message(text, channel)
      SlackCLI::Channel.message(text, channel)
    end

    def channel_details(channel)
      channel_found = @channels.find do |channel_object| 
        channel_object.name == channel || channel_object.id == channel
      end 
      return "Channel not found" if !channel_found
      channel_found.details
    end
    end
  end
