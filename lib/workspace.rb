require_relative "channel"
require_relative "user"

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
      list.each do |elem|
        result << elem.details
        result << "\n-----------------------\n"
      end
      return result
    end

    def send_message(text:)
      return false unless selected
      begin
        ApiWrapper.post(text: text, recipient: selected.id)
      rescue ApiWrapper::SlackError
        return false
      end
      return true
    end
  end
end
