require_relative 'recipient'

module Slack
  class Channels < Recipient

    def initialize(topic:, member_count:)
      @topic = topic
      @member_count = member_count
    end

    def details
      # list details for a specific channel

    end

    def self.list
      # list of all channels
    end

  end
end

# CHANNEL_URL = "https://slack.com/api/channels.list"
# query_params = { token: ENV["SLACK_API_TOKEN"] }
