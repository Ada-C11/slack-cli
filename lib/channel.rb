require "dotenv"
require "HTTParty"
require "pry"

require_relative "recipient"

Dotenv.load

module Slack
  class Channel < Recipient
    CHANNEL_URL = "https://slack.com/api/channels.list"
    @query = { token: KEY }

    attr_reader :slack_id, :name, :topic, :member_count

    def initialize(slack_id, name, topic, member_count)
      @slack_id = slack_id
      @name = name
      @topic = topic
      @member_count = member_count
    end

    def self.list
      response = self.get(CHANNEL_URL, query: @query)
      #   binding.pry
      channels = response["channels"].map do |channel|
        id = channel["id"]
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["num_members"]
        self.new(id, name, topic, member_count)
      end
      return channels
    end
  end
end
