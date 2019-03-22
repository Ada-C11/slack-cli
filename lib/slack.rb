#!/usr/bin/env ruby
require "dotenv"
require_relative "user"
require_relative "channel"
require_relative "workspace"
require_relative "recipient"

def display_options
  options = ["1. List Users",
             "2. List Channels",
             "3. Select User",
             "4. Select Channel",
             "5. Details",
             "6. Send Message",
             "7. Quit"]
  options.each do |one_option|
    puts one_option
  end
end

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
  display_options
  selection = gets.chomp
  until selection == "Quit"
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
      display_options
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
      display_options
      selection = gets.chomp
    when "Select User"
      puts "Here are all the members' user names: #{user_name}"
      chose = gets.chomp #chose_user
      workspace = Workspace.new
      details = workspace.select_user(chose)
      puts "You just selected #{details}"
      puts "What would you like to do next? "
      display_options
      selection = gets.chomp
    when "Select Channel"
      puts "Here are all the channels' names: #{channel_name}"
      chose = gets.chomp #chose_channel
      workspace = Workspace.new
      details = workspace.select_channel(chose)
      puts "You just selected #{details}"
      puts "What would you like to do next? "
      display_options
      selection = gets.chomp
    when "Details"
      puts workspace.show_details(details)
      puts "What would you like to do next? "
      selection = gets.chomp
    when "Send Message"
      puts "Please input your message:"
      message = gets.chomp

      SlackApi.send_message(message, chose)
      puts "What would you like to do next? "
      display_options
      selection = gets.chomp
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
# main
