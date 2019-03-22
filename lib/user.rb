require "httparty"
require "dotenv"
require_relative "recipient"
require "table_print"
require "httparty"
require "pry"

Dotenv.load

module SlackAPI
  class SlackApiError < StandardError; end

  class User < Recipient

    #attr_accessor :status_text, :status_emoji

    attr_reader :real_name, :list

    BASE_URL = "https://slack.com/api"
    USERS_LIST_PATH = "/users.list"
    CHAT_POST_MESSAGE_PATH = "/chat.postMessage"
    TOKEN = ENV["TOKEN"]
    @@list = []

    def initialize(real_name:, slack_id:, name:)
      super(slack_id: slack_id, name: name)
      @real_name = real_name
    end

    def details
      return "Name: #{name}
     Slack ID: #{slack_id}
     Real name: #{real_name}"
    end

    def self.list
      return @@list
    end

    private

    def self.load
      query_parameters = { token: TOKEN }
      response = HTTParty.get(BASE_URL << USERS_LIST_PATH, query: query_parameters)
      response["members"].length.times do |i|
        real_name = response["members"][i]["real_name"]
        slack_id = response["members"][i]["id"]
        name = response["members"][i]["name"]
        new_user = SlackAPI::User.new(real_name: real_name, slack_id: slack_id, name: name)
        @@list.push(new_user)
      end
      return @@list
    end
  end
end
