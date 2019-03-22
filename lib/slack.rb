#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

require_relative 'recipient.rb'
require_relative 'user.rb'
require_relative 'channel.rb'
require_relative 'workspace.rb'


Dotenv.load

def main
######## MESSAGE TO USER #########  
current_session = Workspace.new

  puts "\nWelcome to the Ada Slack CLI!"
  puts "\nThere are #{current_session.channels.length} channels in this workspace."
  puts "There are #{current_session.users.length} users in this workspace."
  puts "Choose your next adventure from the following options: \n
        1. list users \n
        2. list channels \n
        3. see details \n
        4. send message \n
        5. quit"
        
  user_selection = gets.chomp.downcase
    case user_selection
    when "1", "list users" , "users"
      current_session.users.each { |user| puts "username: #{user.name} | real name: #{user.real_name} | Slack ID: #{user.slack_id}" }
      main
    when "2", "list channels" , "channels"
      current_session.channels.each { |channel| puts "name: #{channel.name} | topic: #{channel.topic["value"]} | member count: #{channel.member_count} | Slack ID: #{channel.slack_id}"}
      main
    when "3", "see details", "see", "details"
      puts "Would you like to see details on a user or channel?"
      puts "1. user"
      puts "2. channel"
      selection = gets.chomp.downcase
      print "Enter the name of #{selection}: "
      selection_name = gets.chomp.downcase
        
      puts current_session.show_details(recipient_type: selection, name: selection_name)
      main
    when "4", "select channel", "channel"
      puts "Enter the channel name or Slack_ID"
      channel = gets.chomp
      current_session.select_channel(channel)
    when "7" , "quit"
      puts "Byeeeeeeeeeeeeeee"
      exit
    end
      
    
  puts "\nThank you for using the Ada Slack CLI"  
end

def select_menu
  puts "What would like to do with the selected recipient? \n
        1. details \n
        2. send message \n"
  
end


main if __FILE__ == $PROGRAM_NAME