require "dotenv"
require "httparty"

Dotenv.load

url = "https://slack.com/api/channels.list"

query_parameters = {
  token: ENV["SLACK_API_TOKEN"],
}

response = HTTParty.get(url, query: query_parameters)

if response.code == 200
  puts response
else
  puts "#{response.code} #{response.message}"
end
