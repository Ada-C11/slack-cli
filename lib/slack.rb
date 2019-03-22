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

  puts "\nPlease select from the following options: \n list channels, select channel, list users, select user, or quit"
  selection = gets.chomp.downcase

  until selection == "quit"
    case selection
    when "list channels"
      puts Slack::Workspace.all_channels_details
    when "select channel"
      puts "Which channel would you like to select?"
      channel_identifier = gets.chomp.to_s
      selected_channel = Slack::Workspace.select_channel(channel_identifier)
      if selected_channel.nil?
        puts "This channel doesn't exist. Exiting to main menu"
      else
        puts "You have selected #{selected_channel.name}. Please type 'details' for more info or quit!"
        answer = gets.chomp.downcase
        case answer
        when "details"
          puts Slack::Workspace.selected_channel_details(selected_channel)
        when "quit"
        else
          puts "Please select a valid input. Returning to main!"
        end
      end
    when "list users"
      puts Slack::Workspace.all_users_details
    when "select user"
      puts "Which user would you like to select?"
      user_identifier = gets.chomp.to_s
      selected_user = Slack::Workspace.select_user(user_identifier)
      if selected_user.nil?
        puts "This user doesn't exist. Exiting to main menu"
      else
        puts "You have selected #{selected_user.name}. Please type 'details' for more info or quit!"
        answer = gets.chomp.downcase
        case answer
        when "details"
          puts puts Slack::Workspace.selected_user_details(selected_user)
        when "quit"
        else
          puts "Please select a valid input. Returning to main!"
        end
      end
    when "quit"
    else
      puts "Please enter a valid selection."
    end
    puts "What would you like to do next? (list users, select user, list channels, select channel, or quit)"
    selection = gets.chomp.downcase
  end

  # Should we use a case statement here for the 3 options?

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
