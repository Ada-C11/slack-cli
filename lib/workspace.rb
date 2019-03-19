require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI

  class SlackApiError < Exception; end

  class Workspace
    attr_reader :users, :channels, :selected

    def initialize(users:, channels:)
      @users = users
      @channels = channels
    end
  end

end
  