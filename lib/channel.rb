require_relative "recipient"
require "pry"
require "dotenv"
require "httparty"
require "table_print"

Dotenv.load

module Slack
  class SlackApiError < StandardError; end

  class Channel < Recipient
    attr_reader :name, :id, :topic, :member_count

    def initialize(name:, id:, topic:, member_count:)
      @name = name
      @id = id
      @topic = topic
      @member_count = member_count
    end

    BASE_URL = "https://slack.com/api/"
    CHANNEL_URL = "https://slack.com/api/channels.list"

    def self.send_message(text, channel)
      body = {
        text: text,
        channel: channel,
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.post("#{BASE_URL}/chat.postMessage",
                               body: body,
                               headers: { "Content-Type" => "application/x-www-form-urlencoded" })

      unless response.code == 200 && response["ok"]
        raise SlackApiError, "channel_not_found"
      end
      return true
    end

    def details
      return @topic
    end

    def self.channels_get
      query_params = { token: ENV["SLACK_API_TOKEN"] }
      return Slack::Channel.get(CHANNEL_URL, query_params)
    end

    def self.list
      response = Slack::Channel.channels_get
      channels = response["channels"].map do |channel|
        name = channel["name"]
        id = channel["id"]
        topic = channel["topic"]["value"]
        member_count = channel["members"].count

        Slack::Channel.new(name: name, id: id, topic: topic, member_count: member_count)
      end

      return channels
    end
  end
end