module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end

    def select_channel(input)
      select(input, channels)
    end

    def select_user(input)
      select(input, users)
    end

    def tp_details_options
      if selected.class == Slack::User
        return tp_user_options
      elsif selected.class == Slack::Channel
        return tp_channel_options
      end
    end

    def tp_user_options
      return :name, :real_name, :slack_id
    end

    def tp_channel_options
      return :name, :topic, :member_count, :slack_id
    end

    def send_message(message)
      selected.send_message(message)
    end

    private

    def select(input, recipients)
      recipients.each do |recipient|
        if input == recipient.slack_id || input == recipient.name
          @selected = recipient
          return "#{input} selected".green
        end
      end
      return "#{input} does not exist".red
    end
  end
end
