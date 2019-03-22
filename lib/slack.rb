#!/usr/bin/env ruby
require_relative "workspace.rb"
require "table_print"

# :nocov:

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = SlackCLI::Workspace.new
  puts "There are #{workspace.channels.count} channels in this workspace"
  puts "There are #{workspace.users.count} users in this workspace"

  puts "You can: List Users, List Channels, Select User, Select Channel, Details, Send Message, or Quit."
  puts "Please enter what option you would like to take.  You can quit by entering 'quit'."
  response = gets.chomp.downcase
  while response != "quit"
    if response == "list users"
      list_users(workspace)
    elsif response == "list channels"
      list_channels(workspace)
    elsif response == "select user"
      select_user_by_input(workspace)
    elsif response == "select channel"
      select_channel_by_input(workspace)
    elsif response == "details"
      puts get_details(workspace)
    elsif response == "send message"
      send_message(workspace)
    else
      puts "Please make sure to select from the choices above. You can quit be entering 'quit'."
    end
    puts "\nPlease enter what you would like to do: \nList Users \nList Channels \nSelect User \nSelect Channel \nDetails \nSend Message \nQuit"
    puts
    response = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
end

def list_users(workspace)
  tp workspace.users, "slack_id", "name", "real_name"
end

def list_channels(workspace)
  tp workspace.channels, "slack_id", "name", "topic", "member_count"
end

def select_user_by_input(workspace)
  puts "What is the Slack ID or username? "
  user_info = gets.chomp
  user = workspace.select_user(user_info)
  if user == nil
    puts "We couldn't find that user"
  else
    puts "User has been selected"
  end
end

def select_channel_by_input(workspace)
  puts "What is the Slack ID or name? "
  channel_info = gets.chomp
  channel = workspace.select_channel(channel_info)
  if channel == nil
    puts "We couldn't find that channel"
  else
    puts "Channel has been selected"
  end
end

def get_details(workspace)
  detail_info = workspace.show_details
  if detail_info == nil
    puts "There is nothing selected to show details about. Please select a user or channel."
  else
    return detail_info
  end
end

def send_message(workspace)
  puts "What would you like to send?"
  message = gets.chomp
  if workspace.send_message(message)
    puts "Message successfully sent"
  else
    puts "Please select a channel or user before sending message."
  end
end
# :nocov:
main if __FILE__ == $PROGRAM_NAME
