#!/usr/bin/env ruby
require_relative "channel"
require "httparty"
require "dotenv"
require "awesome_print"
require "pry"

Dotenv.load

BASE_URL = "https://slack.com/api/channels.list"
query_parameters = {
  token: ENV["OAUTH_ACCESS_TOKEN"],
}

response = HTTParty.get(BASE_URL, query: query_parameters)
if (response.code == 200)
  binding.pry
  response["channels"].each do |channel|
    puts channel["name"]
  end
else
  puts "Error #{response.code} : #{response["message"]}"
end

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
