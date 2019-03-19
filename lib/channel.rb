require "httparty"
require "dotenv"
require "pry"
Dotenv.load

class Channel
  attr_reader :name, :topic, :member_count, :id
  BASE_URL = "https://slack.com/api/channels.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def initialize
    @name = name
    @topic = topic
    @member_count = member_count #some code that counts users.
    @id = id
  end

  def details(name, topic, member_count, id)
  end

  def self.list
    #access the response/API above
    # look inside response["members"]
    # return username, real name, and slack ID

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

    # list is an array of arrays
    return list
  end
end
