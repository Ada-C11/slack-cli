#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require_relative '../specs/test_helper.rb'
Dotenv.load

# BASE_URL = 'https://slack.com/api'
# CHANNELS_LIST_PATH = '/channels.list'
# USERS_LIST_PATH = '/users.list'
# CHAT_POST_MESSAGE_PATH = '/chat.postMessage'

token = ENV['TOKEN']

def main
  input = 0

  while input != "quit" do
    puts "Welcome to the Ada Slack CLI!"
    puts "What would you like to do?"
    puts "list users"
    puts "list channels"
    puts "quit"
    input = gets.chomp.downcase

    # while input != "list users" || input != "list channels" || input != "quit"
    #   puts "Please try again"
    #   input = gets.chomp.downcase
    # end

    case input
    when "list users"
      tp SlackAPI::User.list
    when "list channels"
      tp SlackAPI::Channel.list
    end

    puts "Thank you for using the Ada Slack CLI"
  end
end

main if __FILE__ == $PROGRAM_NAME