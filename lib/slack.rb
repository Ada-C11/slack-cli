#!/usr/bin/env ruby
require "table_print"
require "HTTParty"
require "dotenv"
Dotenv.load

require_relative "../lib/recipient.rb"
require_relative "../lib/user.rb"
require_relative "../lib/channel.rb"
require_relative "../lib/workspace.rb"

def get_user_input(options)
  input = gets.chomp.to_s.strip
  unless options.include?(input)
    puts "Please choose option from list"
    input = gets.chomp.to_s.strip
  end
  return input
end

def list_options
  puts "Please choose from these options"
  puts "Enter 'list users' to view all users"
  puts "Enter 'list channels' to view all channels"
  puts "Enter 'quit' to quit"
end

def create_table(array)
  tp array
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackBot::Workspace.new

  while true
    list_options
    options = ["list users", "list channels", "quit"]
    choice = get_user_input(options)
    case choice
    when "list users"
      #puts "#{workspace.users}"
      puts create_table(workspace.users)
    when "list channels"
      #puts "#{workspace.channels}"
      puts create_table(workspace.channels)
    when "quit"
      puts "Goodbye!"
      exit
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
