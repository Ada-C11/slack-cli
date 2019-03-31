require "dotenv"
require "httparty"
Dotenv.load
require "ap"

BASE_URL = "https://slack.com/api/channels.list"
query = {
  token: ENV["SLACK_API_TOKEN"],
}
channel_info = HTTParty.get(BASE_URL, query: query)
channel_list = channel_info["channels"]
channel_names = channel_list.map do |channel|
  channel["name"]
end
ap channel_names
