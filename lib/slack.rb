#!/usr/bin/env ruby
require_relative "workspace"

def main
  workspace = Slack::Workspace.new
  puts "\nWelcome to the Ada Slack CLI!"
  puts "-------------------------------"
  puts "\nWorkspace: Sav-Elise-API Project"
  puts "Number of users: #{workspace.users.length}"
  puts "Number of channels: #{workspace.channels.length}\n\n"
  options = ["List Users", "List Channels", "Select User", "Select Channel", "Details", "Send Message", "Quit"]
  while true
    puts "--------OPTIONS--------"
    puts options
    print "\nPlease enter your command: "
    input = gets.chomp.upcase
    case input
    when "LIST USERS"
      list_users workspace
    when "LIST CHANNELS"
      list_channels workspace
    when "SELECT USER"
      select_user workspace
    when "SELECT CHANNEL"
      select_channel workspace
    when "SEND MESSAGE"
      send_message workspace
    when "DETAILS"
      details workspace
    when "QUIT"
      break
    else
      puts "Command not recognized. Try again!\n\n"
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

def list_users(workspace)
  list = workspace.list_all(list: workspace.users)
  if list.empty?
    puts "Unable to access users at this time."
  else
    puts "\n" + list + "\n"
  end
end

def list_channels(workspace)
  list = workspace.list_all(list: workspace.channels)
  if list.empty?
    puts "Unable to access channels at this time."
  else
    puts "\n" + list + "\n"
  end
end

def select_user(workspace)
  print "Please enter user's name, real name or id: "
  input = gets.chomp.upcase
  user = workspace.find_user(input: input)
  if user
    workspace.select_recipient(recipient: user)
    puts "Successfully upated selected user to #{user.name}.\n\n"
  else
    puts "#{input.capitalize} is not a valid user.\n\n"
  end
end

def select_channel(workspace)
  print "Please enter channel's name or id: "
  input = gets.chomp.upcase
  channel = workspace.find_channel(input: input)
  if channel
    workspace.select_recipient(recipient: channel)
    puts "Successfully upated selected channel to #{channel.name}.\n\n"
  else
    puts "#{input.capitalize} is not a valid channel.\n\n"
  end
end

def send_message(workspace)
  recipient = workspace.selected
  if recipient
    puts "Please enter the message you want to send:"
    message = gets.chomp
    if message.empty?
      puts "Error: No message to send.\n\n"
    else
      workspace.send_message(text: message)
      puts "Message was sent to #{recipient.name}.\n\n"
    end
  else
    puts "Error: first select channel or user.\n\n"
  end
end

def details(workspace)
  details = workspace.details_for_selected
  if details.empty?
    puts "Error: first select channel or user.\n\n"
  else
    puts "\n" + details + "\n\n"
  end
end

main if __FILE__ == $PROGRAM_NAME
