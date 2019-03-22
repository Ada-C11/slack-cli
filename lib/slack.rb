#!/usr/bin/env ruby

# implement details code
# make a method
# messages

require_relative "workspace"
require "table_print"

def main
  workspace = Slack::Workspace.new
  puts "Welcome to the Ada Slack CLI! \n
  There are #{workspace.channels.length} channels and #{workspace.users.length} users\n
  What would you like to do?"

  commands = ["list users", "list channels", "select user", "select channel", "details", "quit"]

  puts "Here are your options:\n"
  puts commands

  input = gets.chomp.downcase

  until input == "quit"
    case input
    when "list users"
      tp workspace.users, :name, :slack_id, :real_name
      puts "Great, what would you like to do next?"
      input = gets.chomp.downcase
    when "list channels"
      tp workspace.channels, :name, :topic, :slack_id, :member_count
      puts "Great, what would you like to do next?"
      input = gets.chomp.downcase
    when "select user"
      puts "Please type in username or Slack ID"
      user = gets.chomp
      selected_user = workspace.select_user(user)
      if selected_user
        puts "You selected user #{selected_user.name}"
        puts "What would you like to do next?"
        puts commands
        input = gets.chomp
      else
        puts "This user does not exist"
        puts "What would you like to do next?"
        puts commands
        input = gets.chomp
      end
    when "select channel"
      puts "Please type in channel name or Slack ID"
      channel = gets.chomp
      selected_channel = workspace.select_channel(channel)
      if selected_channel
        puts "You selected the channel called \'#{selected_channel.name}\'"
        puts "What would you like to do next?"
        puts commands
        input = gets.chomp
      else
        puts "This channel does not exist"
        puts "What would you like to do next?"
        puts commands
        input = gets.chomp
      end
    when "details"
      if workspace.show_details == nil
        puts "No user or channel is selected"
        puts "What would you like to do next?"
        puts commands
        input = gets.chomp
      else
        puts workspace.show_details
        puts "What would you like to do next?"
        puts commands
        input = gets.chomp
      end
    else
      puts "Command not valid. Please type one of the following"
      puts commands
      input = gets.chomp
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

# Make sure all user input gets checked/converted for casing issues (.upcase for usernames, etc.)

main if __FILE__ == $PROGRAM_NAME
