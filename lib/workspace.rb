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

    def select_channel(identifier)
      @selected = @channels.find do |channel|
        channel.slack_id == identifier || channel.name == identifier
      end
    end

    def select_user(identifier)
      @selected = @users.find do |user|
        user.slack_id == identifier || user.name == identifier
      end
    end

    def show_details
      puts @selected.details
    end

    def send_message
    end
  end
end
