module Slack
  class Workspace
    attr_reader :users, :channels
    attr_accessor :selected # only needed here because of tests... that seems wrong?

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

    def show_details(test: false) # This is the only method that prints anything.
      puts "No recipient selected".red unless selected || test

      if selected.class == Slack::User
        tp selected, :name, :real_name, :slack_id unless test
        return selected
      elsif selected.class == Slack::Channel
        tp selected, :name, :topic, :member_count, :slack_id unless test
        return selected
      else
        return nil
      end
    end

    def send_message
    end

    private

    def select(input, recipients)
      recipients.each do |recipient|
        if input == recipient.slack_id || input == recipient.name
          @selected = recipient
          return input
        end
      end
      return "#{input} does not exist"
    end
  end
end
