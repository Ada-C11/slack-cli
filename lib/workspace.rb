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
      @users = SlackApi::User.user_api("https://slack.com/api/users.list", ENV["SLACK_API_TOKEN"])
      @channels = SlackApi::Channel.channel_api("https://slack.com/api/channels.list", ENV["SLACK_API_TOKEN"])
      @selected = ""
    end

    def select_channel(user_input)
      @channels.each do |channel|
        if channel["name"] == user_input || channel["id"] == user_input
          @selected = channel
          return true
        end
      end
      return false
    end

    def select_user(user_input)
      @users.each do |user|
        if user["name"] == user_input || user["id"] == user_input
          @selected = user
          return true
        end
      end
      return false
    end

    def show_details
      if @channels.include?(@selected)
        channel_details = "\nChannel name: #{@selected["name"]}\nSlack ID: #{@selected["id"]}\nTopic: #{@selected["topic"]["value"]}\nMember count: #{@selected["num_members"]}"

        return channel_details
      elsif @users.include?(@selected)
        user_details = "\nUsername: #{@selected["name"]}\nSlack ID: #{@selected["id"]} \nReal name: #{@selected["real_name"]}"

        return user_details
      else
        error_message = "\n~You have not selected a user or channel yet.~"
        return error_message
      end
    end

    def send_message(message)
      url = "https://slack.com/api/chat.postMessage"
      key = ENV["SLACK_API_TOKEN"]

      if @channels.include?(@selected) || @users.include?(@selected)
        response = HTTParty.post(
          url,
          headers: { "Content-Type" => "application/x-www-form-urlencoded" },
          body: {
            token: key,
            text: message,
            channel: @selected["id"],
          },
        )
        if response["ok"]
          return true
        else
          raise SlackApi::SlackError, "Error when posting message to #{@selected["name"]}, error: #{response["error"]}"
        end
      else
        error_message = "\n~You have not selected a user or channel yet.~"
        return error_message
      end
    end
  end
end
