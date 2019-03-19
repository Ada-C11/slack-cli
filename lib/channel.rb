require "dotenv"
require "httparty"
Dotenv.load
require "pry"

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

  def self.list
    query = {
      token: TOKEN,
    }
    channel_info = HTTParty.get(BASE_URL, query: query)
    if channel_info.code != 200
      raise ArgumentError, "The error code is #{channel_info.code} and the reason is: #{channel_info.message}"
    else
      channel_list = channel_info["channels"]
      @channel_names = channel_list.map do |channel|
        channel["name"]
      end
      return @channel_names
    end
  end
end
