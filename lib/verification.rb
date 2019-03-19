require "httparty"
require "pry"
require "dotenv"
Dotenv.load

BASE_URL = "https://slack.com/api/channels.list"
query = {
  token: ENV["SLACK_API_TOKEN"],
}

response = HTTParty.get(BASE_URL, query: query)

response["channels"].each do |channel|
  print channel["name"]
end
# code snips to save:
# puts channel["topic"]["value"] # gets topic
# puts channel["members"].length # gets # of members
# puts channel["id"] # gets slack id for channel
