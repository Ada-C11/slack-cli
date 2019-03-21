module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = User.create_users
      @channels = Channel.create_channels
      @selected = nil
    end
  end
end
