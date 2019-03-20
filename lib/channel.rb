module Slack
  class Channel < Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      super(slack_id, name)
    end

    def self.get
      url = "https://slack.com/api/channels.list"
      params = {
        token: ENV["KEY"],
      }

      response_from_get = HTTParty.get(url, query: params)

      return response_from_get
    end

    def self.list_all
      if Channel.get.code != 200
        raise ArgumentError, "Request is unsuccessful"
      else all_channels = Channel.get["channels"].map do |channel|
        channel["name"]
      end       end
    end
  end
end
