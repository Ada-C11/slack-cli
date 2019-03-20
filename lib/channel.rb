require "dotenv"
require "httparty"
require "awesome_print"

require_relative "recipient"

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end

    #temp
    def self.list
      list = []

      response = self.get("https://slack.com/api/channels.list")

      response["channels"].each do |channel|
        slack_id = channel["id"]
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["num_members"]

        list << Slack::Channel.new(slack_id, name, topic, member_count)
      end
    end
  end
end
