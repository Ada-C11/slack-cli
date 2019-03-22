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

    def select_user(user_info)
      @selected = find_user(user_info)
    end

    def select_channel(channel_info)
      @selected = find_channel(channel_info)
    end

    def show_details
      return @selected == nil ? nil : @selected.details
    end

    def send_message(message)
      return false if @selected != nil
      @selected.send_message(message)
      return true
    end

    private

    def find_user(user_info)
      @users.each do |user|
        if user_info == user.slack_id || user_info == user.name
          return user
        end
      end
      return nil
    end

    def find_channel(channel_info)
      @channels.each do |channel|
        if channel_info == channel.slack_id || channel_info == channel.name
          return channel
        end
      end
      return nil
    end
  end
end
