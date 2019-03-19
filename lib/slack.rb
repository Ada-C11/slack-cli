#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'


Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"



  url = "https://slack.com/api/channels.list"
  key = ENV["TOKEN"]
  puts key

  # def get_channels(search_term)
    query = {
      token: key,
    }

  response = HTTParty.get(url, query: query)
  puts response


    puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME