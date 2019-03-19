#!/usr/bin/env ruby

require "dotenv"
require "httparty"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  puts "to be filled in here"

  url = "https://slack.com/api/channels.list"

  query = {
    token: ENV["KEY"],
  }

  response = HTTParty.get(url, query: query)

  if response.code != 200
    raise ArgumentError, "Request is unsuccessful"
  elsif list_channel = response["channels"].map do |channel|
    channel["name"]
  end
  end

  puts list_channel

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
