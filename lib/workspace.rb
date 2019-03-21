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

    def select_channel
    end 

    def select_user(id_or_name: nil)
        users.each do |user|
            if user.name == id_or_name
                @selected = user
            elsif user.slack_id == id_or_name
                @selected = user
            end
        end
        return @selected
    end

    def show_details
    end

    def send_message
    end
  end
end