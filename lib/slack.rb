#!/usr/bin/env ruby
require "table_print"
require "HTTParty"
require "dotenv"
Dotenv.load

require_relative "../lib/recipient.rb"
require_relative "../lib/user.rb"
require_relative "../lib/channel.rb"
require_relative "../lib/workspace.rb"

def get_user_options_input(options)
  input = gets.chomp.to_s.strip
  unless options.include?(input)
    puts "Please choose option from list"
    input = gets.chomp.to_s.strip
  end
  return input
end

def get_user_input(message_to_user)
  input = gets.chomp.to_s.strip
  until input.length > 0
    puts message_to_user
    input = gets.chomp.to_s.strip
  end
  return input
end

def list_options
  puts "Please choose from these options"
  puts "Enter 'list users' to view all users"
  puts "Enter 'list channels' to view all channels"
  puts "Enter 'select user' to select a user"
  puts "Enter 'select channel' to select a channel"
  puts "Enter 'details' to display information about currently selected recipient"
  puts "Enter 'send message' to send a message to selected recipient"
  puts "Enter 'quit' to quit"
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackBot::Workspace.new

  while true
    list_options
    options = ["list users", "list channels", "select user", "select channel", "details", "send message", "quit"]
    choice = get_user_options_input(options)
    case choice
    when "list users"
      tp workspace.list_users
    when "list channels"
      tp workspace.list_channels
    when "select user"
      puts "Please enter a user ID or user name"
      input = get_user_input("Please enter an ID or name")
      selected = workspace.select_user(input)
      puts "Sorry, no user with that information" if selected == nil
    when "select channel"
      puts "Please enter a channel name channel ID"
      input = get_user_input
      selected = workspace.select_channel(input)
      puts "Sorry, no channel with that information" if selected == nil
    when "details"
      tp [selected.details]
    when "send message"
      if !workspace.selected
        puts "A recipient needs to be selected first"
      else
        puts "Enter the message you would like to send: "
        message_to_send = get_user_input("Message must be at least one character")
        workspace.send_message(message_to_send)
      end
    when "quit"
      puts "Goodbye!"
      exit
    end
    puts "\n\n"
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
