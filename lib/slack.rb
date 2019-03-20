#!/usr/bin/env ruby
# require "dotenv"
# require "httparty"
require_relative "user"
require_relative "channel"

Dotenv.load

def main
  channels_list = SlackApi::Channel.channel_api
  users_list = SlackApi::User.user_api

  puts "Welcome to the Ada Slack CLI!"
  puts "What would you like to do?:"
  puts "list users"
  puts "list channels"
  puts "quit"

  user_selection = gets.chomp
  until user_selection == "quit"
    case user_selection
    when "list users"
      SlackApi::User.list(users_list)
    when "list channels"
      SlackApi::Channel.list(channels_list)
    end
    puts "\nWhat would you like to do next?"
    puts "list users"
    puts "list channels"
    puts "quit"
    user_selection = gets.chomp
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
