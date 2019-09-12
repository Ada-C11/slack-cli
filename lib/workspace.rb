module SlackBot
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = SlackBot::User.list
      @channels = SlackBot::Channel.list
      @selected = nil
    end

    def list_users
      user_list = @users.map do |user|
        user.details
      end
      return user_list
    end

    def list_channels
      channel_list = @channels.map do |channel|
        channel.details
      end
      return channel_list
    end

    def select_user(input)
      found_user = @users.find do |user|
        input == user.id || input == user.name
      end
      @selected = found_user
    end

    def select_channel(input)
      found_channel = @channels.find do |channel|
        input == channel.id || input == channel.name
      end
      @selected = found_channel
    end

    def send_message(message)
      return false if !selected
      selected.send_message(message)
      return true
    end
  end
end
