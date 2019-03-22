#!/usr/bin/env ruby
require_relative "user"
require_relative "channel"
require_relative "workspace"
require "httparty"
require "table_print"
require "dotenv"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "The workspace has #{SlackAPI::Channel.list_channels.length} channels and #{SlackAPI::User.list_users.length} users"
  ask_again = "Select an option: \n1. list users \n2. list channels \n3. select user \n4. select channel \n5. details (select user or channel first)\n6. send message (select user or channel first) \n7. quit"
  puts ask_again
  response = gets.chomp.downcase

  until response == "7" || response == "quit"
    if response == "list users" || response == "1"
      tp SlackAPI::User.list_users, "name", "real name", "slack id"
      puts ask_again
      response = gets.chomp.downcase
    elsif response == "list channels" || response == "2"
      tp SlackAPI::Channel.list_channels, "name", "topic", "member count", "id"
      puts ask_again
      response = gets.chomp.downcase
    elsif response == "select user" || response == "3"
      select_response = "select user"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp.downcase
      user = SlackAPI::Workspace.new
      selected_recipient = user.select_user(identifier)
      if selected_recipient == ""
        puts "There is no user with that identifier"
      end
      puts ask_again
      response = gets.chomp.downcase
    elsif response == "select channel" || response == "4"
      select_response = "select channel"
      puts "What is the user id or Slack name?"
      identifier = gets.chomp.downcase
      channel = SlackAPI::Workspace.new
      selected_recipient = channel.select_channel(identifier)
      if selected_recipient == ""
        puts "There is no channel with that identifier"
      end
      puts ask_again
      response = gets.chomp.downcase
    elsif response == "details" || response == "5"
      if select_response == "select user"
        details = user.see_user_details(selected_recipient)
        tp details, "name", "real name", "slack id"
        puts ask_again
        response = gets.chomp.downcase
      elsif select_response == "select channel"
        details = channel.see_channel_details(selected_recipient)
        tp details, "name", "topic", "member count", "id"
        puts ask_again
        response = gets.chomp.downcase
      else
        puts "Select a user or channel first"
        puts ask_again
        response = gets.chomp.downcase
      end
    elsif response == "send message" || response == "6"
      puts "What would you like to say?"
      text = gets.chomp.downcase
      msg = SlackAPI::Recipient.new.send_msg(selected_recipient, text)
      puts ask_again
      response = gets.chomp.downcase
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
