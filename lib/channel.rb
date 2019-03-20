require_relative "recipient"
require 'dotenv'
Dotenv.load

module SlackCLI
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: slack_id, name: name)

      @topic = topic
      @member_count = member_count
    end

    def self.list
      url = "https://slack.com/api/channels.list"
      data = {
        "token": ENV["SLACK_API_TOKEN"],
      }
      response = self.get(url, data)
      channels = []
      response["channels"].each do |channel|
        slack_id = channel["id"]
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["num_members"]
        channel = self.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count)
        channels << channel
      end
      return channels
    end
  end
end
