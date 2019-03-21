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
  puts "\nQuit"
  option = gets.chomp.downcase
  return option
end

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "\nWhat would you like to do?"
  options = ["select user", "select channel", "details", "quit"]

  option = display_options
  until options.include?(option)
    puts "Please input a valid option."
    option = display_options
  end

  until option == "quit"
    case option
    when "select user"
      puts "You chose to select a user. Please provide a username or Slack ID"
      selected = gets.chomp()
      workspace = Workspace.new(selected: selected)
      selection = workspace.select_user
      until !selection.nil?
        puts "Please provide a valid username or Slack ID"
        selected = gets.chomp
        workspace = Workspace.new(selected: selected)
        selection = workspace.select_user
      end
      puts "You have selected #{selection.real_name}"
      puts "\nWhat would you like to do next?"
      option = display_options
    when "select channel"
      puts "You chose to select a channel. Please provide a channel name or Slack ID"
      selected = gets.chomp()
      workspace = Workspace.new(selected: selected)
      selection = workspace.select_channel
      until !selection.nil?
        puts "Please provide a valid Channel name or Slack ID"
        selected = gets.chomp
        workspace = Workspace.new(selected: selected)
        selection = workspace.select_channel
      end
      puts "You have selected #{selection.name}"
      option = display_options
    when "details"
      selection.details
      puts "\nWhat would you like to do next?"
      option = display_options
    end
  end

  #if option = #, select_user
  #username = gets.chomp
  #workspace = Workspace.new(selected: username)
  #if select show_details, workspace.show_details

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
