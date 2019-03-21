require_relative "recipient"

module Slack
  class Channel < Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name, num_members, topic)
      super(slack_id, name)
      @num_members = num_members
      @topic = topic
    end

    def self.get
      url = "https://slack.com/api/channels.list"
      params = {
        token: ENV["KEY"],
      }

      response_from_get = HTTParty.get(url, query: params)

      if response_from_get["ok"] == false
        raise ArgumentError, "Request is unsuccessful"
      else
        return response_from_get
      end
    end

    def self.list_all
      all_channels = Channel.get["channels"].map do |channel|
        self.new(channel["id"], channel["name"], channel["num_members"], channel["topic"]["value"])
      end
      return all_channels
    end
  end
end
