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

    def select_user(user_descriptor)
      users.find do |user|
        if user_descriptor == user.name || user_descriptor == user.slack_id
          @selected = user
        end
      end

      if @selected == nil
        return "Could not find a user with USER_NAME or SLACK_ID #{user_descriptor}."
      end
    end

    def select_channel(channel_descriptor)
      channels.find do |channel|
        if channel_descriptor == channel.name || channel_descriptor == channel.slack_id
          @selected = channel
        end
      end

      if @selected == nil
        return "Could not find a channel with NAME or SLACK_ID #{channel_descriptor}."
      end
    end

    def show_details #currently_selected_recipient
    end

    def send_message(message)
    end
  end
end
