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

    def details_for_selected
      return "" unless selected
      return selected.details
    end

    def find_user(input:)
      users.each do |user|
        if input == user.name.upcase || input == user.real_name.upcase || input == user.id.upcase
          return user
        end
      end
      return nil
    end

    def find_channel(input:)
      channels.each do |channel|
        if input == channel.name.upcase || input == channel.id.upcase
          return channel
        end
      end
      return nil
    end
  end
end
