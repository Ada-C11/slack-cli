require "awesome_print"
require_relative "recipient"

module Slack
  class Channel < Recipient
    BASE_URL = "https://slack.com/api/channels.list"
    PARAMETERS = { token: ENV["SLACK_API_TOKEN"] }

    attr_reader :topic, :member_count

    def initialize(name, slack_id, topic, member_count)
      super(name, slack_id)
      @name = name
      @topic = topic
      @member_count = member_count
    end

    def self.list
      channel_data = self.get(BASE_URL, PARAMETERS)
      channel_data["channels"].map do |channel|
        self.new(channel["name"], channel["id"], channel["topic"]["value"], channel["members"].length)
      end
    end

    def details
      super.push("topic", "member_count")
    end
  end
end
