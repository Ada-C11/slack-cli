module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end

    def select_channel
    end

    def select_user
    end

    def show_details
    end

    def send_message
    end
  end
end
