require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI
  class SlackApiError < Exception; end

  class Workspace
    attr_reader :users, :channels, :selected

    def initialize(users:, channels:)
      @users = users
      @channels = channels
    end

    def display_users
      return users.map { |user| user.display_details }
    end

    def display_channels
      return channels.map { |channel| channel.display_details }
    end
  end
end
