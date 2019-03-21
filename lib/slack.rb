#!/usr/bin/env ruby
require "pry"
require "httparty"
require "dotenv"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project
  puts "What would you like to do? Type 1 to select a user or 2 to quit"
  option = gets.chomp()
  return if option == 2

  #if option = #, select_user
  #username = gets.chomp
  #workspace = Workspace.new(selected: username)
  #if select show_details, workspace.show_details

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
