#!/usr/bin/env ruby
require_relative "user"
require_relative "channel"

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "The workspace has #{Channel.list_channels.length} channels and #{User.list_users.length} users"
  ask_again = "Would you like to 'list users', 'list channels', 'select user', 'select channel', 'details', or 'quit'?"
  puts ask_again
  response = gets.chomp

  until response == "quit"
    if response == "list users"
      # user = User.new
      puts User.list_users
      puts ask_again
      response = gets.chomp
    elsif response == "list channels"
      puts Channel.list_channels
      puts ask_again
      response = gets.chomp
    elsif response == 'select user'
      # get instance of user
    elsif response == 'select channel'
      # get instance of channel
    elsif response == 'details'
      # get details for selected
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
