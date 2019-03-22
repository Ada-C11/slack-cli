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

  until input == "G" do
    puts "Welcome to the Ada Slack CLI!"
    puts "What would you like to do?"
    puts "[A] List users"
    puts "[B] List channels"
    puts "[C] Select user"
    puts "[D] Select channel"
    puts "[E] Show details of selected user / channel"
    puts "[F] Send message"
    puts "[G] Quit"
    input = gets.chomp.upcase
    valid_input = ["A", "B", "C", "D", "E", "F", "G"]

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
        user_id_or_name = gets.chomp
        selected = workspace.select_user(id_or_name: user_id_or_name)
        if selected 
          puts "Selected user: #{user_id_or_name}"
        else
          puts "User not found"
        end
      when "D"
        puts "Please supply a slack ID or channel name (case sensitive!)"
        workspace.selected = nil
        chan_id_or_name = gets.chomp.downcase
        workspace.select_channel(id_or_name: chan_id_or_name)
        if selected 
          puts "Selected channel: #{chan_id_or_name}"
        else
          puts "Channel not found"
        end
        
      when "E"
        if workspace.selected
          puts workspace.show_details
        else
          puts "No recipient selected \n\n"
        end
      when "F"
        if workspace.selected
          puts "Please type the message you want to send"
          user_text = gets.chomp
          workspace.send_message(text: user_text)
        else
          puts "No recipient selected \n\n"
        end
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME