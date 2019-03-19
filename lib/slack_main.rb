#!/usr/bin/env ruby

require "dotenv"
require "pry"
require "httparty"

Dotenv.load

BASE_URL = "https://slack.com/api/users.list"
query_params = { token: ENV["SLACK_API_TOKEN"] }

response = HTTParty.get(BASE_URL, query: query_params)

# def main
#   puts "Welcome to the Ada Slack CLI!"

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME
