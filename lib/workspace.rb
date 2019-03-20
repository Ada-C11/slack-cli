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
        elsif user.id == value
          @selected = user
          return user
        end
      end
      return nil
    end

    def select_channel()
      # out of list of channels, find the one that matches vlaue
      # set the one that matches value to @selected
    end

    def show_details
    end

    def send_message
    end
  end
end
