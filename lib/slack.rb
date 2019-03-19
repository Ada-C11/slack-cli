#!/usr/bin/env ruby

require "HTTParty"
require "dotenv"
Dotenv.load

url = "https://slack.com/api/channels.list?"
token = ENV["TOKEN"]

query_parameters = {
  token: token,
}

response = HTTParty.get(url, query: query_parameters)

puts response

# def main
#   puts "Welcome to the Ada Slack CLI!"

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME
