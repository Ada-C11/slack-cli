#!/usr/bin/env ruby
# require "dotenv"
# require "httparty"
require_relative "user"
require_relative "channel"
require_relative "workspace"

Dotenv.load

def main
  # channels_list = SlackApi::Channel.channel_api
  # users_list = SlackApi::User.user_api
  workspace = SlackApi::Workspace.new

  user_options = "list users\nlist channels\nselect user\nselect channel\ndetails\nsend message\nquit"

  puts "Welcome to the Ada Slack CLI!"
  puts "What would you like to do?:"
  puts user_options

  user_selection = gets.chomp
  until user_selection == "quit"
    case user_selection
    when "list users"
      puts SlackApi::User.list(workspace.users)
    when "list channels"
      puts SlackApi::Channel.list(workspace.channels)
    when "select user"
      print "Enter username or user's ID: "
      user_input = gets.chomp
      if SlackApi::Workspace.select_user(user_input) != true
        puts "That user does not exist"
      end
    when "select channel"
      print "Enter channel name or channel's ID: "
      user_input = gets.chomp
      if SlackApi::Workspace.select_channel(user_input) != true
        puts "That channel does not exist"
      end
    when "details"
      puts SlackApi::Workspace.show_details
    when "send message"
      puts "(This will send to the recipient you have selected)"
      print "What message would you like to send? "
      user_message = gets.chomp
      SlackApi::Workspace.send_message(user_message)
    end

    puts "\nWhat would you like to do next?"
    puts user_options
    user_selection = gets.chomp
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
