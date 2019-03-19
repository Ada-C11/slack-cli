require "dotenv"
require "httparty"
Dotenv.load
require "ap"
require "pry"

#def main
#puts "Welcome to the Ada Slack CLI!"

BASE_URL = "https://slack.com/api/channels.list"
query = {
  token: ENV["SLACK_API_TOKEN"],
}
channel_info = HTTParty.get(BASE_URL, query: query)
channel_list = channel_info.map do |channel|
  channel["name"]
end
ap channel_list
#puts "Thank you for using the Ada Slack CLI"
#end

#main if __FILE__ == $PROGRAM_NAME
