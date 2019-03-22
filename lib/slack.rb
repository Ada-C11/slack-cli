#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require_relative "recipient.rb"
require_relative "user.rb"
require_relative "channel.rb"
require_relative "workspace.rb"
Dotenv.load

def main
  @current_session = Workspace.new
  # if @current_session.channels.length == 0 || @current_session.users.length == 0
  #   puts "Hmm, this is strange"
  # end

  puts "\nWelcome to the Ada Slack CLI!"
  puts "\nThere are #{@current_session.channels.length} channels in this workspace."
  puts "There are #{@current_session.users.length} users in this workspace."
  puts "Choose your next adventure from the following options: \n
        1. list users \n
        2. list channels \n
        3. see details \n
        4. send message \n
        5. quit"

  user_selection = gets.chomp.downcase
  case user_selection
  when "1", "list users", "users"
    @current_session.users.each do |user|
      puts "username: #{user.name} | real name: #{user.real_name} | Slack ID: #{user.slack_id}"
    end
    main
  when "2", "list channels", "channels"
    @current_session.channels.each do |channel|
      puts "name: #{channel.name} | topic: #{channel.topic["value"]} | member count: #{channel.member_count} | Slack ID: #{channel.slack_id}"
    end
    main
  when "3", "see details", "see", "details"
    see_details_menu
    main
  when "4", "send message", "send"
    send_message_menu
  when "5", "quit"
    puts "Byeeeeeeeeeeeeeee"
    exit
  end

  puts "\nThank you for using the Ada Slack CLI"
end

def see_details_menu
  puts "Would you like to see details on a user or channel?
        \n1. user 
        \n2. channel"
  selection = gets.chomp.downcase
  case selection
  when "1", "user"
    print "Enter the name of user: "
    selection_name = gets.chomp.downcase
    puts @current_session.show_user_details(selection_name)
  when "2", "channel"
    print "Enter the name of channel: "
    selection_name = gets.chomp.downcase
    puts @current_session.show_channel_details(selection_name)
  else
    puts "Recipient type not recognized, choose either a user or channel"
    see_details_menu
  end
end

def send_message_menu
  puts "Would you like to send a message to a user or channel?
  \n1. user 
  \n2. channel"
  selection = gets.chomp.downcase
  case selection
  when "1", "user"
    print "Enter the name of user: "
    selection_name = gets.chomp.downcase
    print "Enter your message: "
    message = gets.chomp
    puts @current_session.send_msg_to_user(selection_name, message)
  when "2", "channel"
    print "Enter the name of channel: "
    selection_name = gets.chomp.downcase
    print "Enter your message: "
    message = gets.chomp
    puts @current_session.send_msg_to_channel(selection_name, message)
  else
    puts "Recipient type not recognized, choose either a user or channel"
    send_message_menu
  end
end

def select_menu
  puts "What would like to do with the selected recipient? \n
        1. see details \n
        2. send message \n"
end

main if __FILE__ == $PROGRAM_NAME
