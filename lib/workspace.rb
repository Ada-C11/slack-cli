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

    def show_details # This is the only method that prints anything.
      puts "No recipient selected".red unless selected

      if selected.class == Slack::User
        tp selected, :name, :real_name, :slack_id
      elsif selected.class == Slack::Channel
        tp selected, :name, :topic, :member_count, :slack_id
      end
    end

    def send_message
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
