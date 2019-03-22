#!/usr/bin/env ruby
require_relative "user"
require_relative "channel"
require "httparty"
require "table_print"
require "dotenv"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "The workspace has #{SlackAPI::Channel.list_channels.length} channels and #{SlackAPI::User.list_users.length} users"
  ask_again = "Would you like to 'list users', 'list channels', 'select user', 'select channel', 'details', 'send message', or 'quit'?"
  puts ask_again
  response = gets.chomp

  until response == "quit"
    if response == "list users"
      tp SlackAPI::User.list_users, "name", "real name", "slack id"
      puts ask_again
      response = gets.chomp
    elsif response == "list channels"
      tp SlackAPI::Channel.list_channels, "name", "topic", "member count", "id"
      puts ask_again
      response = gets.chomp
    elsif response == "select user"
      select_response = "select user"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp
      user = SlackAPI::User.new
      selected_recipient = user.select_user(identifier)
      if selected_recipient == ""
        puts "There is no user with that identifier"
      end
      puts ask_again
      response = gets.chomp
    elsif response == "select channel"
      select_response = "select channel"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp
      channel = SlackAPI::Channel.new
      selected_recipient = channel.select_channel(identifier)
      if selected_recipient == ""
        puts "There is no channel with that identifier"
      end
      puts ask_again
      response = gets.chomp
    elsif response == "details"
      if select_response == "select user"
        details = user.see_details(selected_recipient)
        tp details, "name", "real name", "slack id"
        puts ask_again
        response = gets.chomp
      elsif select_response == "select channel"
        details = channel.see_details(selected_recipient)
        puts details
        puts ask_again
        response = gets.chomp
      end
    elsif response == "send message"
      puts "What would you like to say?"
      text = gets.chomp
      msg = SlackAPI::Recipient.new.send_msg(selected_recipient, text)
      puts ask_again
      response = gets.chomp
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
