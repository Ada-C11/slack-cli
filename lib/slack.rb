#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "Choose an option: \n list users \n list channels \n quit"
  workspace = Workspace.new
  input = ""
  while input != "quit"
    input = gets.chomp
    case input 
    when "list users"
      puts workspace.users
    when "list channels"
      puts workspace.channels
    when "quit"
    
    else 
      puts "Please select one of the options"
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME