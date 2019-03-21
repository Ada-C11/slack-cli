#!/usr/bin/env ruby
# require "dotenv"
# require "httparty"
require_relative "user"
require_relative "channel"
require_relative "workspace"

Dotenv.load

def main
  channels_list = SlackApi::Channel.channel_api
  users_list = SlackApi::User.user_api

  puts "Welcome to the Ada Slack CLI!"
  puts "What would you like to do?:"
  puts "list users"
  puts "list channels"
  puts "select user"
  puts "select channel"
  puts "details"
  puts "quit"

  user_selection = gets.chomp
  until user_selection == "quit"
    case user_selection
    when "list users"
      puts SlackApi::User.list(users_list)
    when "list channels"
      puts SlackApi::Channel.list(channels_list)
    when "select user"
      print "Enter user's name or user's ID: "
      user_input = gets.chomp

      if SlackApi::Workspace.select_user(user_input) != true
        puts "That user does not exist"
      end
    when "select channel"
      print "Enter channel's name or channel's ID: "
      user_input = gets.chomp

      if SlackApi::Workspace.select_channel(user_input) != true
        puts "That channel does not exist"
      end
    when "details"
      puts SlackApi::Workspace.show_details
    end

    puts "\nWhat would you like to do next?"
    puts "list users"
    puts "list channels"
    puts "select user"
    puts "select channel"
    puts "details"
    puts "quit"
    user_selection = gets.chomp
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
