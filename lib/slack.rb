#!/usr/bin/env ruby
require_relative "workspace.rb"

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = SlackCLI::Workspace.new
  puts "There are #{workspace.channels.count} channels in this workspace"
  puts "There are #{workspace.users.count} users in this workspace"

  puts "You can: List Users, List Channels, or Quit."
  puts "Please enter what option you would like to take.  You can exit by entering 'quit'."
  response = gets.chomp.downcase
  while response != "quit"
    if response == "list users"
      puts workspace.users
    elsif response == "list channels"
      planet_choice = solar_system.find_planet_by_name(gets.chomp)
      puts workspace.channels
    else
      puts "Please make sure to select from the choices above. You can quit be entering 'quit'."
    end
    puts "\nPlease enter what you would like to do: \nList Users \nList Channels"
    response = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
