require "dotenv"
require "httparty"

require_relative "channel"
require_relative "user"

Dotenv.load

module SlackApi
  class SlackError < StandardError; end

  class Workspace
    attr_reader :channels, :users

    def initialize
      @users = SlackApi::User.user_api
      @channels = SlackApi::Channel.channel_api
      @selected = ""
    end

    def self.select_channel(user_input)
      (SlackApi::Channel.channel_api).each do |channel|
        if channel["name"] == user_input || channel["id"] == user_input
          @selected = channel
          return true
        end
      end
    end

    def self.select_user(user_input)
      (SlackApi::User.user_api).each do |user|
        if user["name"] == user_input || user["id"] == user_input
          @selected = user
          return true
        end
      end
    end

    def self.show_details
      if (SlackApi::Channel.channel_api).include?(@selected)
        channel_details = "\nChannel name: #{@selected["name"]}\nSlack ID: #{@selected["id"]}\nTopic: #{@selected["topic"]["value"]}\nMember count: #{@selected["num_members"]}"

        return channel_details
      elsif (SlackApi::User.user_api).include?(@selected)
        user_details = "\nUsername: #{@selected["name"]}\nSlack ID: #{@selected["id"]} \nReal name: #{@selected["real_name"]}"

        return user_details
      else
        error_message = "You have not selected a user or channel yet."
        return error_message
      end
    end

    def self.send_message(message)
      if (SlackApi::Channel.channel_api).include?(@selected)
        SlackApi::Channel.send_message(message, @selected)
      elsif (SlackApi::User.user_api).include?(@selected)
        # SlackApi::user .method for sending message to user
      else
        error_message = "You have not selected a user or channel yet."
        return error_message
      end
    end
  end
end
