require_relative "user"
require_relative "channel"

module SlackCLI
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = SlackCLI::User.list
      @channels = SlackCLI::Channel.list
      @selected = nil
    end
  end
end
