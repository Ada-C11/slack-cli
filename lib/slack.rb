#!/usr/bin/env ruby
require 'HTTParty'
require 'dotenv'
require 'awesome_print'
Dotenv.load

url = 'https://slack.com/api/conversations.list'
key = ENV["SLACK_API_KEY"]

query_params = {
  "token": key,
}
response = HTTParty.get(url, query: query_params)

# ap JSON.parse(response.body)

response["channels"].each do |channel|
  ap channel["name"]
end

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME