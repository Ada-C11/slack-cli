#!/usr/bin/env ruby
# require "dotenv"
# require "httparty"
require_relative "user"
require_relative "channel"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "What would you like to do?:"
  puts "list users"
  puts "list channels"
  puts "quit"

  user_selection = gets.chomp

  if user_selection == "list users"
    return User.list
  elsif user_selection == "list channels"
    return Channel.list
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
