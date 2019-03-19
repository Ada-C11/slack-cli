require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI
  class Workspace
    attr_reader :users, :channels

    def initialize(users:, channels:)
      @users = users
      @channels = channels
    end
  end

end
  