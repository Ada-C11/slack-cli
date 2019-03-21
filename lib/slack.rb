#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require_relative 'channel'
require_relative 'recipient'
require_relative 'user'
require_relative 'workspace'
Dotenv.load

# BASE_URL = 'https://slack.com/api'
# CHANNELS_LIST_PATH = '/channels.list'
# USERS_LIST_PATH = '/users.list'
# CHAT_POST_MESSAGE_PATH = '/chat.postMessage'

token = ENV['TOKEN']

def main
  input = 0

  users = SlackAPI::User.load
  channels SlackAPI::Channel.load
  SlackAPI::Workspace.new(users: users, channels: channels)

  until input == "quit" do
    puts "Welcome to the Ada Slack CLI!"
    puts "What would you like to do?"
    puts "list users"
    puts "list channels"
    puts "quit"
    input = gets.chomp.downcase
    valid_input = ["list users", "list channels", "select user", "select channel", "quit"]

    until valid_input.include?(input)
      puts "Please try again"
      input = gets.chomp.downcase
    end

    case input
    when "list users"
      tp SlackAPI::User.list
    when "list channels"
      tp SlackAPI::Channel.list
    else 

    end

    puts "Thank you for using the Ada Slack CLI"
  end
end

main if __FILE__ == $PROGRAM_NAME