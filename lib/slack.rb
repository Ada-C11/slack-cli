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
      puts workspace.print_details("users")
    when "list channels"
      puts workspace.print_details("channels")
    when "quit"
    else
      puts "Please select one of the options"
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
