#!/usr/bin/env ruby
require_relative "user"
require_relative "channel"
require "httparty"
require "dotenv"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "The workspace has #{SlackAPI::Channel.list_channels.length} channels and #{SlackAPI::User.list_users.length} users"
  ask_again = "Would you like to 'list users', 'list channels', 'select user', 'select channel', 'details', or 'quit'?"
  puts ask_again
  response = gets.chomp

  until response == "quit"
    if response == "list users"
      # user = User.new
      puts SlackAPI::User.list_users
      puts ask_again
      response = gets.chomp
    elsif response == "list channels"
      puts SlackAPI::Channel.list_channels
      puts ask_again
      response = gets.chomp
    elsif response == "select user"
      select_response = "select user"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp
      user = SlackAPI::User.new
      selected_user = user.select_user(identifier)
      if selected_user == ""
        puts "There is no user with that identifier"
      end
      puts ask_again
      response = gets.chomp
    elsif response == "select channel"
      select_response = "select channel"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp
      channel = SlackAPI::Channel.new
      selected_channel = channel.select_channel(identifier)
      if selected_channel == ""
        puts "There is no channel with that identifier"
      end
      puts ask_again
      response = gets.chomp
    elsif response == "details"
      # if select_response == "select user"
      details = user.see_details(selected_user)
      #   puts details
      # elsif select_response == "select channel"
      #   details = channel.see_details(selected_channel)
      #   puts details
      # end
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
