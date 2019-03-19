require "httparty"
require "pry"
require "dotenv"
Dotenv.load

class Channel

  # def initialize

  # end

  BASE_URL = "https://slack.com/api/channels.list"

  # class SlackError < StandardError; end

  def self.list_channels
    query = {
      token: ENV["SLACK_API_TOKEN"],
    }
    channel_list = {}
    response = HTTParty.get(BASE_URL, query: query)

    if response.code != 200
      raise ArgumentError, "There was an error. The code is #{response.error}."
    else
      response["channels"].each do |channel|
        channel_list[channel["name"]] = {"topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"]}
        # binding.pry
      end
    end
    return channel_list
  end
end
  

  # code snips to save:
  # puts channel["topic"]["value"] # gets topic
  # puts channel["members"].length # gets # of members
  # puts channel["id"] # gets slack id for channel

