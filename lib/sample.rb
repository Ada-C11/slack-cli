require "dotenv"
require "httparty"
require "awesome_print"

Dotenv.load

url = "https://slack.com/api/channels.list"

query_parameters = {
  token: ENV["SLACK_API_TOKEN"],
}

response = HTTParty.get(url, query: query_parameters)

if response.code == 200
  ap response.parsed_response
else
  ap "#{response.code} #{response.message}"
end
