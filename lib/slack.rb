#!/usr/bin/env ruby
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = Workspace.new
  input = ""
  while input != "quit"
    puts "Choose an option: \n list users \n list channels \n quit"
    input = gets.chomp
    case input
    when "list users"
      workspace.print_user_details
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
