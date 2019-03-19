require "dotenv"
require "httparty"
Dotenv.load
require "pry"
require "httparty"
require "dotenv"
Dotenv.load

module Slack
  class Channel
    attr_reader :topic, :member_count
    attr_accessor :channel_names
    BASE_URL = "https://slack.com/api/channels.list"
    TOKEN = ENV["SLACK_API_TOKEN"]

    def initialize
      @topic = topic
      @member_count = member_count
      @channel_names = []
    end

    def list
      query = {
        token: TOKEN,
      }
      channel_info = HTTParty.get(BASE_URL, query: query)
      channel_list = channel_info["channels"]
      @channel_names = channel_list.map do |channel|
        channel["name"]
      end
      return @channel_names
    end
  end
end

# channel = Channel.new
# channel.list
# puts channel.channel_names
