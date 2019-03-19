# require "dotenv"
# require "HTTParty"
# require "pry"

# Dotenv.load

# KEY = ENV["SLACK_TOKEN"]
# url = "https://slack.com/api/channels.list"
# query = { token: KEY }

# def self.get(url, query)
# response = HTTParty.get(url, query: query)
# if response.code != 200
#     raise SlackApiError
#     puts "Invalid request, error #{response.code}"
#   puts
#   puts response.code
# else
#   response["channels"].each do |channel|
#     puts channel["name"]
#   end
# end
