# Use the dotenv gem to load environment variables
# Use HTTParty to send a GET request to the channels.list endpoint
# Check that the request completed successfully, and print relevant information to the console if it didn't
# Loop through the results and print out the name of each channel

require "dotenv"
require "HTTParty"
require "pry"

Dotenv.load

KEY = ENV["SLACK_TOKEN"]
url = "https://slack.com/api/channels.list"
query = { token: KEY }

response = HTTParty.get(url, query: query)
binding.pry
if response.code != 200
  puts response.reason
  puts response.code
else
  response["channels"].each do |channel|
    puts channel["name"]
  end
end
