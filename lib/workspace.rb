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
      return  tp users, :username, :real_name, :slack_id 
    end

    def display_channels
      return tp channels, :id, :channel_name, :members, :topic => {:width => 120}
    end
  end
end
