#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

Dotenv.load

def main
  url = "https://slack.com/api/channels.list"
  user_url = "https://slack.com/api/users.list"
  
  key = ENV["TOKEN"]
    query = {
      token: key,
    }

  channel_response = HTTParty.get(url, query: query)
  user_response = HTTParty.get(user_url, query: query)

  channel_count = channel_response["channels"].count
  user_count = user_response["members"].count
 
  channel_response["channels"].each do |channel|
    puts channel["name"]
  end
  
  
  
  puts "Welcome to the Ada Slack CLI!"
  puts "There are #{channel_count} channels in this workspace."
  puts "There are #{user_count} users in this workspace."
  puts "Thank you for using the Ada Slack CLI"
end



main if __FILE__ == $PROGRAM_NAME