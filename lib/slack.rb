#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require_relative 'channel'
require_relative 'recipient'
require_relative 'user'
require_relative 'workspace'
Dotenv.load

# BASE_URL = 'https://slack.com/api'
# CHANNELS_LIST_PATH = '/channels.list'
# USERS_LIST_PATH = '/users.list'
# CHAT_POST_MESSAGE_PATH = '/chat.postMessage'

token = ENV['TOKEN']

def main
  input = 0

  users = SlackAPI::User.load
  channels = SlackAPI::Channel.load
  workspace = SlackAPI::Workspace.new(users: users, channels: channels)

  until input == "E" do
    puts "Welcome to the Ada Slack CLI!"
    puts "What would you like to do?"
    puts "[A] List users"
    puts "[B] List channels"
    puts "[C] Select user"
    puts "[D] Select channel"
    puts "[E] Quit"
    input = gets.chomp.upcase
    valid_input = ["A", "B", "C", "D", "E"]

    until valid_input.include?(input)
      puts "Please try again"
      input = gets.chomp.upcase
    end

    case input
      when "A"
        tp SlackAPI::User.list
      when "B"
        tp SlackAPI::Channel.list
      when "C"
        puts "Please supply a slack ID or user name (case sensitive!)"  
        # Resets selected
        workspace.selected = nil
        # Needs error checking
        user_id_or_name = gets.chomp
        selected = workspace.select_user(id_or_name: user_id_or_name)
        if selected == nil
          puts "User not found"
        end
        puts "[A] show details for #{user_id_or_name}"
        puts "[B] Go back to main menu"
        # Needs error checking
        user_details_input = gets.chomp.upcase
        if user_details_input == "A"
          puts workspace.show_details
        # All other input goes back to main menu
        end
      when "D"
        puts "Please supply a slack ID or user name (case sensitive!)"
        workspace.selected = nil
        chan_id_or_name = gets.chomp.downcase
        workspace.select_channel(id_or_name: chan_id_or_name)
        if selected == nil
          puts "User not found"
        end
        puts "[A] show details for #{chan_id_or_name}"
        puts "[B] Go back to main menu"
        # Needs error checking
        chan_details_input = gets.chomp.upcase
        if chan_details_input == "A"
          puts workspace.show_details
        # All other input goes back to main menu
        end
    end

    puts "Thank you for using the Ada Slack CLI"
  end
end

main if __FILE__ == $PROGRAM_NAME