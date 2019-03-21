# workspace file for keeping all things slack
require "dotenv"
require "httparty"

require_relative "user"
require_relative "channels"

Dotenv.load

module Slack
  class Workspace
    URL = "https://slack.com/api/users.list"
    attr_reader :users, :channels
    attr_accessor :selected

    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end

    def select_user(user_descriptor) #return user or id/set the selected user
      users.find do |user|
        if user_descriptor == user.name || user_descriptor == user.slack_id
          @selected = user
        end
      end

      if @selected == nil
        return "Could not find a user with that USER_NAME or SLACK_ID."
      end
    end

    # users.each do |user|
    #     if name == user.name || name == user.slack_id     end

    def select_channel(channel_descriptor)
    end

    def show_details #currently_selected_recipient
    end

    def send_message(message)
    end
  end
end
