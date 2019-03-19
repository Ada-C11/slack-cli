#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
Dotenv.load

BASE_URL = 'https://slack.com/api'
CHANNELS_LIST_PATH = '/channels.list'
USERS_LIST_PATH = '/users.list'
CHAT_POST_MESSAGE_PATH = '/chat.postMessage'

token = ENV['TOKEN']

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "Channel names: #{list_channels}"
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME