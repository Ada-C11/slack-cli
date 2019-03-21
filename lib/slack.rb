#!/usr/bin/env ruby
require "pry"
require "httparty"
require "dotenv"
require_relative "../lib/workspace"
Dotenv.load

def display_options
  puts "\nWhat would you like to do?"
  puts "\nChoose from one of the following:"
  puts "------------------------------"
  puts "\nSelect user"
  puts "\nSelect channel"
  puts "\nDetails"
  puts "\nQuit"
  option = gets.chomp.downcase
  return option
end

def main
  puts "Welcome to the Ada Slack CLI!"
  option = display_options

  until option == "quit"
    case option
    when "select user"
      puts "You chose to select a user. Please provide a username or Slack ID"
      selected = gets.chomp()
      workspace = Workspace.new(selected: selected)
      user = workspace.select_user
      until !user.nil?
        puts "Please provide a valid username or Slack ID"
        selected = gets.chomp
        workspace = Workspace.new(selected: selected)
        user = workspace.select_user
      end
      puts "You have selected #{user.real_name}"
      option = display_options
    when "select channel"
      puts "You chose to select a channel. Please provide a channel name or Slack ID"
      selected = gets.chomp()
      workspace = Workspace.new(selected: selected)
      channel = workspace.select_channel
      until !channel.nil?
        puts "Please provide a valid Channel name or Slack ID"
        selected = gets.chomp
        workspace = Workspace.new(selected: selected)
        channel = workspace.select_channel
      end
      puts "You have selected #{channel.name}"
      option = display_options
    when "details"
    end
  end

  return if option == 2

  #if option = #, select_user
  #username = gets.chomp
  #workspace = Workspace.new(selected: username)
  #if select show_details, workspace.show_details

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
