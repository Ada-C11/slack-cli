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
      # if selected_channel == nil
      #   puts "This channel doesn't exist. Exiting to main menu"
      # else
      #   puts "You have selected #{selected_channel.name}. Please type 'details' for more info!"
      #   answer = gets.chomp.downcase
      #   if answer == "details"
      #     puts selected_channel

      # end
      # if answers
    when "list users"
      puts Slack::Workspace.all_users_details
      # when "select user"
      #   puts "Which user would you like to select?"
      #   user_identifier = gets.chomp.downcase.to_s
      #   selected_user = Slack::Workspace.select_channel(user_identifier)
      # puts selected_channel
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

def send_message(user, message)
  url = "https://slack.com/api/chat.postMessage"
  params = {
    token: ENV["KEY"],
    channel: user_identifier,
    text: message,
  }

  message_request = HTTParty.post(URL, query: params)
    if message_request["ok"] == false
      raise ArgumentError, "Request is unsuccessful"
    else
      return message_request
    end
  end
end

def send_message(channel, message)
  url = "https://slack.com/api/chat.postMessage"
  params = {
    token: ENV["KEY"],
    channel: channel_identifier,
    text: message,
  }

  message_request = HTTParty.post(URL, query: params)
    if message_request["ok"] == false
      raise ArgumentError, "Request is unsuccessful"
    else
      return message_request
    end
  end
end
