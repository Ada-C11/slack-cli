module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = User.create_users
      @channels = Channel.create_channels
      @selected = nil
    end

    def select_channel(channel:)
      @selected = channel
      return true
    end

    def select_user(user:)
      @selected = user
      return true
    end

    def list_all(list:)
      result = ""
      return result
    end
  end
end
