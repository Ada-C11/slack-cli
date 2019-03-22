#!/usr/bin/env ruby

require_relative "workspace"
require "table_print"

def main
  workspace = Slack::Workspace.new
  puts "Welcome to the Ada Slack CLI! \n
  There are #{workspace.channels.length} channels and #{workspace.users.length} users\n"

  commands = ["list users", "list channels", "select user", "select channel", "details", "send message", "quit"]

  while true
    puts "\nWhat would you like to do?"
    puts
    puts commands
    puts
    input = gets.chomp.downcase

    case input
    when "list users"
      tp workspace.users, :name, :slack_id, :real_name
    when "list channels"
      tp workspace.channels, :name, :topic, :slack_id, :member_count
    when "select user"
      puts "Please type in username or Slack ID"
      user = gets.chomp
      selected_user = workspace.select_user(user)
      if selected_user
        puts "You selected user #{selected_user.name}"
      else
        puts "This user does not exist"
      end
    when "select channel"
      puts "Please type in channel name or Slack ID"
      channel = gets.chomp
      selected_channel = workspace.select_channel(channel)
      if selected_channel
        puts "You selected the channel called \'#{selected_channel.name}\'"
      else
        puts "This channel does not exist"
      end
    when "details"
      if workspace.show_details == nil
        puts "No user or channel is selected"
      else
        puts workspace.show_details
      end
    when "send message"
      if workspace.selected == nil
        puts "No user or channel selected. Try again"
      else
        puts "Write your message here"
        message = gets.chomp
        workspace.send_message(message)
      end
    when "quit"
      break
    else
      puts "Command not valid. Please type one of the following"
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

# Make sure all user input gets checked/converted for casing issues (.upcase for usernames, etc.)

main if __FILE__ == $PROGRAM_NAME
