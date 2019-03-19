require "HTTParty"
require "awesome_print"

module Slack
  class Channel
    class SlackError < StandardError; end

    CHANNEL_URL = "https://slack.com/api/channels.list"
    query_parameters = {
      token: ENV["SLACK_API_TOKEN"],
    }

    attr_reader :channel_id, :channel_name, :topic, :member_count
    attr_accessor :channel_name, :topic

    def initialize(channel_id, channel_name, topic)
      @channel_id = channel_id
      @channel_name = channel_name
      @topic = topic
      @member_count = member_count
    end # initialize

    # def self.list
    #   response = HTTParty(CHANNEL_URL, query: query_parameters)
    #   ap ENV["SLACK_API_TOKEN"]

    #   if(response.code == 200)
    # end # self.list
  end # class
end # module
