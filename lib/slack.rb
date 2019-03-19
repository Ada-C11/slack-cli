#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
Dotenv.load

<<<<<<< HEAD
BASE_URL = 'https://slack.com/api'
CHANNELS_LIST_PATH = '/channels.list'
USERS_LIST_PATH = '/users.list'
CHAT_POST_MESSAGE_PATH = '/chat.postMessage'

token = ENV['TOKEN']
=======
class SlackAPI


  class SlackAPIError < StandardError; end

end

def main
  puts "Welcome to the Ada Slack CLI!"
>>>>>>> 5348b3269c38949f34dd238e6b3d833644bcdb73

def list_channels
  channel_names = []
  query_parameters = {
    token: ENV['TOKEN'],
  }
  channels = HTTParty.get(BASE_URL << CHANNELS_LIST_PATH, query: query_parameters)['channels']
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