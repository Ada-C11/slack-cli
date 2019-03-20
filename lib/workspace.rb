require "dotenv"
require "httparty"

require_relative "channel"
require_relative "user"

Dotenv.load

module SlackApi
  class SlackError < StandardError; end

  class Workspace
    def initialize
      @users = SlackApi::User.user_api
      @channels = SlackApi::Channel.channel_api
      # @selected = ""
    end

    def self.select_channel(user_input)
      #--> take user_input and put into @selected
      @channels.each do |channel|
        if channel["name"] == user_input || channel["id"] == user_input
          @selected = channel
          return true
        end
      end
    end

    def self.select_user(user_input)
      # --> take user_input and put into @selected
      @users.each do |user|
        if user["name"] == user_input || user["id"] == user_input
          @selected = user
          return true
        end
      end
    end

    # def show_details
    # --> takes @selected and returns details
    # end
  end
end
