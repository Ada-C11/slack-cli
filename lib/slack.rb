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

  print "Channels loaded: ", Slack::Workspace.channel_list_all.length

  print "\nUsers loaded: ", Slack::Workspace.user_list_all.length

  puts "\nPlease select from the following options: \n list channels, select channel, list users, select user, details, or quit"
  selection = gets.chomp.downcase

  until selection == "quit"
    case selection
    when "list channels"
      puts Slack::Workspace.all_channels_details
    when "select channel"
      puts "Which user would you like to select?"
      user_identifier = gets.chomp.downcase.to_s
      selected_channel = Slack::Workspace.select_user(user_identifier)
      puts "You have selected #{selected_channel.name}. Please type 'details' for more info!"
      answer = gets.chomp.downcase
      if answer == "details"
        "#{selected_channel.name}'s detail: \nID - #{selected_channel.slack_id}\n'"
        puts "Please type 'details' if you would like to see complete details."
      end
      # if answers
    when "list users"
      puts Slack::Workspace.all_users_details
    when "select user"
      puts "Which user would you like to select?"
      user_identifier = gets.chomp.downcase.to_s
      selected_user = Slack::Workspace.select_channel(user_identifier)
      # puts selected_channel
    when "quit"
    else
      puts "Please enter a valid selection."
    end
    puts "What would you like to do next? (list users, select user, list channels, select channel, or quit)"
    selection = gets.chomp.downcase
  end

  #   if selection == "list channels"

  #   elsif selection == "select channel"

  #     puts "Please type 'details' if you would like to see complete details."
  #     answer = gets.chomp.downcase
  #   elsif selection == "list users"
  #     puts Slack::Workspace.all_users_details
  #   elsif selection == "select user"
  #     puts "Which user would you like to select?"
  #     channel_identifier = gets.chomp.to_s
  #     selected_user = Slack::Workspace.select_user(channel_identifier)
  #     puts "Please type 'details' if you would like to see complete details."
  #     answer = gets.chomp.downcase
  #   else

  #   end
  #   puts "What would you like to do next? (list users, select user, list channels, select channel, or quit)"
  #   selection = gets.chomp.downcase
  # end

  # Should we use a case statement here for the 3 options?

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
