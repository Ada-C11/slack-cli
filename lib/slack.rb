#!/usr/bin/env ruby
require "dotenv"
require "httparty"

Dotenv.load

class Channel
  BASE_URL = "https://slack.com/api/channels.list"
  key = ENV["SLACK_API_TOKEN"]

  query_parameters = { 'token': key }

  response = HTTParty.get(BASE_URL, query: query_parameters)

  puts "Here are a list of your channels for this Workspace:"
  response["channels"].each do |channel|
    puts channel["name"]
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "What would you like to do?:"
  puts "list users"
  puts "list channels"
  puts "quit"

  user_selection = gets.chomp

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
