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
    elsif response == "select user"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp
      user = User.new
      selected_user = user.select_user(identifier)
      if selected_user == ""
        puts "There is no user with that identifier"
      end
      puts ask_again
      response = gets.chomp
    elsif response == "select channel"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp
      channel = Channel.new
      selected_channel = channel.select_user(identifier)
      if selected_channel == ""
        puts "There is no channel with that identifier"
      end
      puts ask_again
      response = gets.chomp
    elsif response == "details"
      # selected_user or selected_channel is parameter for get details method, loop through api response and return hash with details
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
