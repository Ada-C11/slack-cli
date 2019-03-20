#!/usr/bin/env ruby
require 'httparty'
require 'awesome_print'
require 'dotenv'
require_relative '../lib/recipient'
require_relative '../lib/channel'
require_relative '../lib/user'
Dotenv.load
# require 'table_print'

def main
  ap "Welcome to the Ada Slack CLI!"

  def menu
    puts
    ap "Main Menu"
    puts "a. list users"
    puts "b. select user"
    puts "c. list channels"
    puts "d. select channel"
    puts "e. details for selected user and channel"
    puts "f. send message"
    puts "g. quit\n\n"

    ap "What would you like to do?"
    print "> "
    @menu_response = gets.chomp.downcase.delete(".")
    puts
  end

  users = User.get_users
  channels = Channel.get_channels
  recipient = nil
  continue = true 

  puts "There are #{channels.length} channels and #{users.length} users."

  while (continue)
    menu
    if @menu_response == "a" || @menu_response == "list users"
      ap "All users in the Slack workspace: "
      User.list_users(users)
    elsif @menu_response == "b" || @menu_response == "select user"
      user = User.select_user(users)
      if user.nil?
        puts "Error. User not found."
      else
        recipient = Recipient.new(user["id"], true)
      end
    elsif @menu_response == "c" || @menu_response == "list channels"
      ap "All channels in the Slack workspace: "
      Channel.list_channels(channels)
    elsif @menu_response == "d" || @menu_response == "select channel"
      channel = Channel.select_channel(channels)
      if channel.nil?
        puts "Error. Channel not found."
      else
        recipient = Recipient.new(channel["id"], false)
      end
    elsif @menu_response == "e" || @menu_response == "details"
      if recipient.nil?
        puts "No details to show, please select a channel or user."
      else
        if recipient.details(user["id"]) == nil
          recipient.details(channel["id"])
        else
          recipient.details(user["id"])
        end
      end
    elsif @menu_response == "f" || @menu_response == "send message"
      puts "Okay, you want to send a message."
      puts "What is the SlackID or name of the channel?"
      print "> "
      channel = gets.chomp

      puts "What is the message you want to send?"
      print "> "
      text = gets.chomp

      url = 'https://slack.com/api/chat.postMessage'
      query_parameters = {
        token: ENV['SLACK_API_TOKEN'],
        channel: channel,
        text: text,
      }

      HTTParty.post(url, query: query_parameters)

    elsif @menu_response == "g" || @menu_response == "quit"
      ap "Okay, good-bye! Thank you for using the Ada Slack CLI!"
      continue = false
    else
      ap "Invalid input. To quit, choose c."
      menu
    end
  end
end


main if __FILE__ == $PROGRAM_NAME