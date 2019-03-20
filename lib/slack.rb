#!/usr/bin/env ruby
require_relative "user"
require "dotenv"
require "httparty"

Dotenv.load

# URL = "https://slack.com/api/channels.list"

# response = HTTParty.get(URL, query: {token: ENV["KEY"]})

# (0..response["channels"].length - 1).each do |index|
#   puts response["channels"][index]["name"]
# end
module Slack
  def main
    puts "Welcome to the Ada Slack CLI!"

    url = "https://slack.com/api/users.list"
    query = {token: ENV["KEY"]}
    potato = User.get(url, query)
    puts User.list(potato)

    puts "Thank you for using the Ada Slack CLI"
  end
end

main if __FILE__ == $PROGRAM_NAME
