require 'dotenv'
require 'httparty'
require 'pry'
Dotenv.load

module SlackAPI
  class Workspace

  attr_reader :users, :channels
  attr_accessor :selected

    def initialize(users:, channels:, selected: nil)
      @users = users
      @channels = channels
      @selected = selected
    end

    def select_channel(id_or_name:)
        @channels.each do |channel|
            if channel.name == id_or_name
                @selected = channel
            elsif channel.slack_id == id_or_name
                @selected = channel
            end
        end
        return @selected
    end 

    def select_user(id_or_name:)
        @users.each do |user|
            if user.name == id_or_name
                @selected = user
            elsif user.slack_id == id_or_name
                @selected = user
            end
        end
        return @selected
    end

    def show_details
        @selected.details
    end

    def send_message(text:, recipient:)
        @selected.send_message(text: text, recipient: recipient)
    end
  end
end