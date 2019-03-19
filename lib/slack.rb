#!/usr/bin/env ruby
require 'dotenv'
require 'HTTParty'

# To verify that you've set up the Slack token correctly, work with your partner to write a script that does the following:

# 1. Use the `dotenv` gem to load environment variables
# 1. Use HTTParty to send a `GET` request to the [`channels.list` endpoint](https://api.slack.com/methods/channels.list)
# 1. Check that the request completed successfully, and print relevant information to the console if it didn't
# 1. Loop through the results and print out the name of each channel

# If your tokens are set up correctly, each of you should be able to run this script.

Dotenv.load

class SearchError < StandardError; end

url = "https://api.slack.com/methods/channels.list"
key = ENV["TOKEN"]

def get_channels(key)
  query = {
    token: key,
  }

response = HTTParty.get(url, query: query)

  unless response.code == 200
    raise SearchError, "Cannot find #{search_term}"
  end
  puts response
end



def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME