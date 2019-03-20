module Slack
  class Channel < Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      super(slack_id, name)
      # @members = members
      # @topic = topic
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
        "Channel #{channel["id"]} name is: #{channel["name"]}. Number of members: #{channel["num_members"]}. Topic of the channel: #{channel["topic"]["value"]}."
      end
      return all_channels
    end
  end
end
