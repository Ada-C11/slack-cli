#!/usr/bin/env ruby
require "pry"
require "httparty"
require "dotenv"
require_relative "../lib/workspace"
Dotenv.load

def display_options
  puts "\nChoose from one of the following:"
  puts "------------------------------"
  puts "\nSelect user"
  puts "\nSelect channel"
  puts "\nDetails"
  puts "\nMessage"
  puts "\nQuit"
  option = gets.chomp.downcase
  return option
end

def verify_options(option)
  options = ["select user", "select channel", "details", "message", "quit"]
  until options.include?(option)
    puts "Please input a valid option."
    option = display_options
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "\nWhat would you like to do?"

  option = display_options
  verify_options(option)

  until option == "quit"
    case option
    when "select user"
      puts "You chose to select a user. Please provide a username or Slack ID"
      selected = gets.chomp()
      workspace = Workspace.new(selected: selected)
      recipient = workspace.select_user
      until !recipient.nil?
        puts "Please provide a valid username or Slack ID"
        selected = gets.chomp
        workspace = Workspace.new(selected: selected)
        recipient = workspace.select_user
      end
      puts "You have selected #{recipient.real_name}"
      puts "\nWhat would you like to do next?"
      option = display_options
      verify_options(option)
    when "select channel"
      puts "You chose to select a channel. Please provide a channel name or Slack ID"
      selected = gets.chomp()
      workspace = Workspace.new(selected: selected)
      recipient = workspace.select_channel
      until !recipient.nil?
        puts "Please provide a valid Channel name or Slack ID"
        selected = gets.chomp
        workspace = Workspace.new(selected: selected)
        recipient = workspace.select_channel
      end
      puts "You have selected #{recipient.name}"
      option = display_options
      verify_options(option)
    when "details"
      begin
        recipient.details
        puts "\nWhat would you like to do next?"
        option = display_options
        verify_options(option)
      rescue
        puts "You must select a user or channel first."
        puts "\nWhat would you like to do next?"
        option = display_options
        verify_options(option)
      end
    when "message"
      begin
        recipient.slack_id #checking if recipient exists; if it doesn't will throw name error => rescue clause
        puts "What message would you like to send?"
        message = gets.chomp
        workspace.send_message(message, recipient)
        puts "\nYou're message has been sent."
        puts "\nWhat would you like to do next?"
        option = display_options
        verify_options(option)
      rescue
        puts "You must select a user or channel first."

        puts "\nWhat would you like to do next?"
        option = display_options
        verify_options(option)
      end
    end
  end

  #if repeat details

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
