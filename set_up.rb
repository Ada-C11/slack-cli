# Use the dotenv gem to load environment variables
# Use HTTParty to send a GET request to the channels.list endpoint
# Check that the request completed successfully, and print relevant information to the console if it didn't
# Loop through the results and print out the name of each channel

require 'dotenv'
Dotenv.load

require 'HTTParty'
require 'pry'

BASE_URL = "https://slack.com/api/channels.list"

query_params = {
  token: ENV['BANANA']
}

response = HTTParty.get(BASE_URL, query: query_params)



response["channels"].each do |channel|
  puts "#{channel["name"]}"
end
