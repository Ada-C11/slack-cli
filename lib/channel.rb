require "dotenv"
Dotenv.load
require "httparty"

class Channel
  attr_reader :channel_name, :id, :topic, :members, :member_count
  BASE_URL = "https://slack.com/api/channels.list"
  TOKEN = ENV["SLACK_API_TOKEN"]

  def initialize(channel_name, id, topic, members)
    @channel_name = channel_name
    @id = id
    @topic = topic
    @members = members
    @member_count = members.length
  end

  def self.get
    query = {
      token: TOKEN,
    }
    channel_info = HTTParty.get(BASE_URL, query: query)
    if channel_info["ok"] == false
      raise ArgumentError, "The error code is #{channel_info.code} and the reason is: #{channel_info.message}"
    end
    return channel_info
  end

  def self.list
    channel_info = Channel.get
    channel_list = channel_info["channels"]
    channels = channel_list.map do |channel|
      Channel.new(channel["name"], channel["id"], channel["topic"]["value"], channel["members"])
    end
    return channels
  end
end
