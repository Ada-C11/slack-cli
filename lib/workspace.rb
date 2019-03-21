require "pry"
require "dotenv"
require "httparty"
require "table_print"

require_relative "user"
require_relative "channel"

module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = Slack::User.list
      @channels = Slack::Channel.list
      @selected = nil
    end

    def select_channel(slack_id)
      selected_channel = @channels.find { |channel| channel.slack_id == slack_id }
      return selected_channel
    end

    def select_user(slack_id)
      selected_user = @users.find { |user| user.slack_id == slack_id }
      return selected_user
    end

    def show_details
    end

    def send_message
    end
  end
end
