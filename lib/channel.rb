require "httparty"
require "dotenv"
require "pry"
Dotenv.load

class Channel
  attr_reader :name, :topic, :member_count, :id
  BASE_URL = "https://slack.com/api/channels.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def self.list
    query_param = {
      token: SLACK_TOKEN,
    }
    response = HTTParty.get(BASE_URL, query: query_param)

    list = []
    response["channels"].each do |channel|
      channel_info = []
      channel_info << channel["name"]
      channel_info << channel["topic"]["value"]
      channel_info << channel["num_members"]
      channel_info << channel["id"]

      list << channel_info
    end

    return list
  end
end
