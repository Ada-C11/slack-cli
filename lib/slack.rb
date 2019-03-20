#!/usr/bin/env ruby
# require "httparty"

# PURPOSE OF THIS FILE IS TO HOLD CLI PROMPTS

# class Slack
#   def initialize
#   end

#   def main
#     puts "Welcome to the Ada Slack CLI!"

#     puts "Slack CLI Menu\n"
#     puts "1. List Users\n"
#     puts "2. List Channels\n"
#     puts "3. Quit\n"

#     loop do
#       puts "Please enter your selection from the above options."
#       input = gets.chomp.to_s
#       case
#       when input == "1"
#         puts users.list
#       when input == "2"
#         puts channels.list
#       when input == "3"
#         exit
#       when input =~ /[[:alpha:]]/
#         puts "\nYour request was invalid."
#       end
#     end

#    puts "Thank you for using the Ada Slack CLI"
#   end

#   main if __FILE__ == $PROGRAM_NAME
