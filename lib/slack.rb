#!/usr/bin/env ruby
# require_relative "../spec/test_helper"
require_relative "channel"
require_relative "user"
require_relative "recipient"
require_relative "workspace"
require "dotenv"
require "httparty"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  puts "Channels loaded: ", Slack::Workspace.channel_list_all.length

  puts "Users loaded: ", Slack::Workspace.user_list_all.length

  puts "Please select from the following options: list users, list channels, or quit"

  selection = gets.chomp.downcase

  until selection == "quit"
    if selection == "list channels"
      puts Slack::Workspace.all_channels_details
    elsif selection == "list users"
      puts Slack::Workspace.all_users_details
    else
      puts "Please enter a valid selection."
    end
    puts "What would you like to do next? (list users, list channels, or quit)"
    selection = gets.chomp.downcase
  end

  # Should we use a case statement here for the 3 options?

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
