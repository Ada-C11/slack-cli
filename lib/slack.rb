#!/usr/bin/env ruby
require "pry"
require "httparty"
require "dotenv"
Dotenv.load
# BASE_URL = "https://slack.com/api/channels.list"
# query_params = {token: ENV["SLACK_API_TOKEN"]}
# response = HTTParty.get(BASE_URL, query: query_params)
# p response
# # Binding.pry

# p response["channels"].map { |channel| channel["name"] }

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project
  puts "What would you like to do? Type 1 to select a user or 2 to quit"
  option = gets.chomp()
  return if option == 2
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
