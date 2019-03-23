require_relative "recipient"
require "pry"
require "dotenv"
require "httparty"
require "table_print"

Dotenv.load

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end

    BASE_URL = "https://slack.com/api/"
    CHANNEL_URL = "https://slack.com/api/channels.list"

    def details
      return {
        Name: @name.capitalize,
        Slack_id: @slack_id,
        Topic: @topic,
        Member_count: @member_count
      }
    end

    def self.channels_get
      query_params = { token: ENV["SLACK_API_TOKEN"] }
      return Slack::Channel.get(CHANNEL_URL, query_params)
    end

    def self.list
      response = Slack::Channel.channels_get
      channels = response["channels"].map do |channel|
        name = channel["name"]
        slack_id = channel["id"]
        topic = channel["topic"]["value"]
        member_count = channel["members"].count

        Slack::Channel.new(name: name, slack_id: slack_id, topic: topic, member_count: member_count)
      end

      return channels
    end
  end
end
