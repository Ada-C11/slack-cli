require "httparty"
require "pry"
require "dotenv"
Dotenv.load

class Channel
  

  # def initialize

  # end

  BASE_URL = "https://slack.com/api/channels.list"

  def self.list_channels
    
  query = {
    token: ENV["SLACK_API_TOKEN"],
  }

  response = HTTParty.get(BASE_URL, query: query)
    response["channels"].each do |channel|
     puts channel["name"]
  end
end
end
  

  # code snips to save:
  # puts channel["topic"]["value"] # gets topic
  # puts channel["members"].length # gets # of members
  # puts channel["id"] # gets slack id for channel

