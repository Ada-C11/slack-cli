#!/usr/bin/env ruby
require "dotenv"
require_relative "user"
require_relative "channel"
require_relative "workspace"
require_relative "recipient"

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "We currently have #{User.list.length} members and #{Channel.list.length} channels."

  # user_input = true
  puts ""
  puts "Please choose one of the the following number options"
  puts "1. List Users"
  puts "2. List Channels"
  puts "3. Select User"
  puts "4. Select Channel"
  puts "5. Send Message"
  puts "6. Quit"
  selection = gets.chomp
  until selection == "6"
    # # loop d
    # break if selection == "6"
    # until user_input == false

    #TODO: add command list every time teh loop repreats
    case selection
    when "1"
      puts "Here is the list of users:"
      puts User.list
      puts "What would you like to do next? "
      selection = gets.chomp
    when "2"
      puts "Here is the list of channels: "
      puts Channel.list
      puts "What would you like to do next? "
      selection = gets.chomp
    when "3"
      chose_user = gets.chomp
      workspace = Workspace.new
      details = workspace.select_user(chose_user)
      puts details
      puts "What would you like to do next? "
      selection = gets.chomp
    when "4"
      chose_channel = gets.chomp
      workspace = Workspace.new
      details = workspace.select_channel(chose_channel)
      puts details
      puts "What would you like to do next? "
      selection = gets.chomp
    when "details"
      puts workspace.show_details_channel(details)
      puts "What would you like to do next? "
      selection = gets.chomp
    when "5"
      channel_name = Channel.list.map do |channel|
        channel[0]
      end
      puts "Here is a list of channels: #{channel_name}"

      user_name = User.list.map do |user|
        user[0]
      end
      puts "Here is a list of Users#{user_name}"
      puts "Input the person's or channel's name you'd like to send to: "
      recipient = gets.chomp
      puts "Please input your message:"
      message = gets.chomp

      SlackApi.send_message(message, recipient)
      puts "What would you like to do next? "
      selection = gets.chomp
      # when "6"
      #   user_input = false
    end
    # break
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
# main
