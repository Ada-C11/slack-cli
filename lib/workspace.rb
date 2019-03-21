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
      #--> take user_input and put into @selected
      (SlackApi::Channel.channel_api).each do |channel|
        if channel["name"] == user_input || channel["id"] == user_input
          @selected = channel
          return true
        end
      end
    end

    def self.select_user(user_input)
      # --> take user_input and put into @selected
      (SlackApi::User.user_api).each do |user|
        if user["name"] == user_input || user["id"] == user_input
          @selected = user
          return true
        end
      end
    end

    def self.show_details
      # --> takes @selected and returns details
      if (SlackApi::Channel.channel_api).include?(@selected)
        channel_details = "\nChannel name: #{@selected["name"]}\nSlack ID: #{@selected["id"]}\nTopic: #{@selected["topic"]["value"]}\nMember count: #{@selected["num_members"]}"

        return channel_details
      end

      if (SlackApi::User.user_api).include?(@selected)
        user_details = "\nUsername: #{user["name"]}\nSlack ID: #{user["id"]} \nReal name: #{user["real_name"]}"

        return user_details
      end 
    end
  end
end
