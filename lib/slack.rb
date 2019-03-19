#!/usr/bin/env rub
require "dotenv"

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "We currently have #{User.list.length} members and #{Channel.list.length} channels."

  puts ""
  puts "Please choose one of the the following number options"
  puts "1. List Users"
  puts "2. List Channels"
  puts "3. Quit"

  selection = gets.chomp

  loop do
    if selection == "1"
      puts "Here is the list of users:"
      puts User.list
    elsif selection == "2"
      puts "Here is the list of channels: "
      puts Channel.list
    elsif selection == "3"
      break
    else
      puts "Please choose one of the the following number options"
      puts "1. List Users"
      puts "2. List Channels"
      puts "3. Quit"

      selection = gets.chomp
    end
  end
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
# main
