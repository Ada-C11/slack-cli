require_relative "recipient"
require "pry"
require "dotenv"
require "httparty"
require "table_print"

Dotenv.load

module Slack

  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji

    def initialize(real_name:, status_text:, status_emoji:)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    BASE_URL = "https://slack.com/api/"
    USER_URL = "https://slack.com/api/users.list"

    # If supplied user name or slack id then select corresponding user
    # def self.select_user(slack_id)
    #   selected_user = list.find {|user| user.id == slack_id}
    #   return selected_user
    # end

    # def self.send_message(text, channel)
    #   body = {
    #     text: text,
    #     channel: channel,
    #     token: ENV["SLACK_API_TOKEN"],
    #   }

    #   response = HTTParty.post("#{BASE_URL}/chat.postMessage",
    #                            body: body,
    #                            headers: { "Content-Type" => "application/x-www-form-urlencoded" })

    #   unless response.code == 200 && response["ok"]
    #     raise SlackApiError, "user_not_found"
    #   end
    #   return true
    # end

    def details
      return @real_name
    end

    def self.users_get
      query_params = { token: ENV["SLACK_API_TOKEN"] }
      return Slack::User.get(USER_URL, query_params)
    end

    def self.list
      response = Slack::User.users_get
      users = response["members"].map do |member|
        real_name = member["real_name"]
        status_text = member["profile"]["status_text"]
        status_emoji = member["profile"]["status_emoji"]

        Slack::User.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji)
      end

      return users
    end
    




  


  end
end


