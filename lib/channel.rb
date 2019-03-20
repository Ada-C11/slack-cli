require_relative "recipient"
require "pry"
require "dotenv"
require "httparty"
require "table_print"

Dotenv.load

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(topic:, member_count:)
      @topic = topic
      @member_count = member_count
    end

    CHANNEL_URL = "https://slack.com/api/channels.list"

    def details

      # list details for a specific channel

    end

    def self.list
      query_params = { token: ENV["SLACK_API_TOKEN"] }

      response = Slack::Channel.get(CHANNEL_URL, query_params)
      channels = response["channels"].map do |channel|
        name = channel["name"]
        id = channel["id"]
        topic = channel["topic"]["value"]
        member_count = channel["members"].count

        Slack::Channel.new(topic: topic, member_count: member_count)
      end

      return channels
    end
  end
end

# query_params = { token: ENV["SLACK_API_TOKEN"] }
