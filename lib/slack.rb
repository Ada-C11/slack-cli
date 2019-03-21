#!/usr/bin/env ruby
require "dotenv"
require_relative "user"
require_relative "channel"
require_relative "workspace"
require_relative "recipient"

### WHAT DID I CHANGE
#1. formatting for outputting List ____
#2. moved channel_name and user_name to top
#3. added to workspace class - show_details uses channel_name.include? or user_name.include?
#4. added to workspace class - select_user or select_channel returns SELECTED = string

def main
  channel_name = Channel.list.map do |channel|
    channel[0]
  end
  user_name = User.list.map do |user|
    user[0]
  end
  puts "Welcome to the Ada Slack CLI!"
  puts "We currently have '#{User.list.length}' members and '#{Channel.list.length} channels.'"
  puts ""
  puts "Please choose one of the the following options"
  puts "List Users"
  puts "List Channels"
  puts "Select User"
  puts "Select Channel"
  puts "Details"
  puts "Send Message"
  puts "Quit"
  selection = gets.chomp
  until selection == "Quit"

    #TODO: add command list every time teh loop repreats
    # TODO: format output for listing
    case selection
    when "List Users"
      puts "Here is the list of users and their details:"
      User.list.each do |user|
        puts "Username: #{user[0]}"
        puts "Real Name: #{user[1]}"
        puts "Slack_ID: #{user[2]}"
        puts ""
      end
      puts "What would you like to do next? "
      selection = gets.chomp
    when "List Channels"
      puts "Here is the list of channels and their details: "
      Channel.list.each do |channel|
        puts "Name: #{channel[0]}"
        puts "Topic: #{channel[1]}"
        puts "Member Count: #{channel[2]}"
        puts "Slack_ID: #{channel[3]}"
        puts ""
      end
      puts "What would you like to do next? "
      selection = gets.chomp
    when "Select User"
      puts "Here are all the members' user names: #{user_name}"
      chose = gets.chomp #chose_user
      workspace = Workspace.new
      details = workspace.select_user(chose)
      puts "You just selected #{details}"
      puts "What would you like to do next? "
      selection = gets.chomp
    when "Select Channel"
      puts "Here are all the channels' names: #{channel_name}"
      chose = gets.chomp #chose_channel
      workspace = Workspace.new
      details = workspace.select_channel(chose)
      puts "You just selected #{details}"
      puts "What would you like to do next? "
      selection = gets.chomp
    when "Details"
      ###### JUST CHANGED
      puts workspace.show_details(details)
      puts "What would you like to do next? "
      selection = gets.chomp
    when "Send Message"
      puts "Please input your message:"
      message = gets.chomp

      ### WE NEED TO ROUTE PATH TO CORRECT LIKE OF SEND MESSAGE

      SlackApi.send_message(message, chose)
      # SlackApi.send_message(message, chose_channel)
      puts "What would you like to do next? "
      selection = gets.chomp
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
# main
