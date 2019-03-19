#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
Dotenv.load

BASE_URL = 'https://slack.com/api/channels.list'
token = ENV['TOKEN']

def list_channels
  channel_names = []
  query_parameters = {
    token: ENV['TOKEN'],
  }
  channels = HTTParty.get(BASE_URL, query: query_parameters)['channels']
  channel_names = channels.map do |channel|
    channel['name']
  end
  return channel_names
end

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "Channel names: #{list_channels}"
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME