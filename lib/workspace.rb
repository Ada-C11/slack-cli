require_relative "user"
require_relative "channel"

module Slack
  class Workspace
    attr_reader :users, :channels
    attr_accessor :selected

    def initialize
      @users = Slack::User.list
      @channels = Slack::Channel.list
      @selected = nil
    end

    def select_user(value)
      @users.each do |user|
        if user.name == value
          @selected = user
          return user
        elsif user.slack_id == value
          @selected = user
          return user
        end
      end
      return nil
    end

    def select_channel(value)
      @channels.each do |channel|
        if channel.name == value
          @selected = channel
          return channel
        elsif channel.slack_id == value
          @selected = channel
          return channel
        end
      end
      return nil
    end

    def show_details
      return selected.details if selected
    end

    def send_message
    end
  end
end
