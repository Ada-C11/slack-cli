#!/usr/bin/env ruby
require "dotenv"
require "httparty"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  url = "https://slack.com/api/channels.list"

  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
  }

  response = HTTParty.get(url, query: query_parameters)
  # TODO project

  if response.code == 200
    puts response
  else
    puts "#{response.code} #{response.message}"
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
