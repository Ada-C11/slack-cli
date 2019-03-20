#!/usr/bin/env rub
require "dotenv"

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "We currently have #{User.list.length} members and #{Channel.list.length} channels."

  puts ""
  puts "Please choose one of the the following number options"
  puts "1. List Users"
  puts "2. List Channels"
  puts "3. Select User"
  puts "4. Select Channel"
  puts "5. Send Message"
  puts "6. Quit"

  selection = gets.chomp

  loop do
    case selection
    when "1"
      puts "Here is the list of users:"
      puts User.list
    when "2"
      puts "Here is the list of channels: "
      puts Channel.list
    when "3"
      chose_user = gets.chomp
      workspace = Workspace.new
      puts workspace.show_details_user(chose_user)
    when "4"
      chose_channel = gets.chomp
      workspace = Workspace.new
      puts workspace.show_details_channel(chose_channel)
    when "6"
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
    when "6"
      break
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
# main
