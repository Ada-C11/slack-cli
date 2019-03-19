#!/usr/bin/env ruby
require "dotenv"
require "httparty"

Dotenv.load

URL = "https://slack.com/api/channels.list"

response = HTTParty.get(URL, query: {token: ENV["KEY"]})

(0..response["channels"].length - 1).each do |index|
  puts response["channels"][index]["name"]
end

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
