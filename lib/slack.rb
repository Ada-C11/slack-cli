#!/usr/bin/env ruby
require_relative "workspace"
require "table_print"
require "colorize"

Dotenv.load

# module Slack
def main
  # users = Slack::User
  # channel = Slack::Channel
  workspace = Slack::Workspace.new

  puts "Welcome to the Ada Slack CLI!".colorize(:magenta)
  print "#{workspace.users.length} users and #{workspace.channels.length} ".colorize(:magenta)
  puts "channels were uploaded.".colorize(:magenta)

  selection = 1
  while selection != 6
    puts "\nPlease make a selection:\n".colorize(:magenta)
    puts "1. list users".colorize(:blue)
    puts "2. list channels".colorize(:green)
    puts "3. select user".colorize(:blue)
    puts "4. select channel".colorize(:green)
    puts "5. details".colorize(:yellow)
    puts "6. send message".colorize(:yellow)
    puts "7. quit\n".colorize(:light_red)

    selection = gets.chomp

    case selection
    when "1", "list users"
      tp workspace.users, "slack_id", :Name => {:display_method => "real_name"},
                                      :include => {:User_Name => {:display_method => "name"}}
    when "2", "list channels"
      tp workspace.channels, "name", "slack_id", "topic", "member_count"
    when "3", "select_user"
      print "Please enter in the user's USER_NAME or SLACK_ID: ".colorize(:blue)
      user_descriptor = gets.chomp
      puts "\n#{workspace.select_user(user_descriptor)}".colorize(:light_red)
    when "4", "select channel"
      print "Please enter in the channel's NAME or SLACK_ID: ".colorize(:green)
      channel_descriptor = gets.chomp
      puts "\n#{workspace.select_channel(channel_descriptor)}".colorize(:light_red)
    when "5", "details"
      if workspace.show_details == false
        puts "No channel or user has been selected.".colorize(:light_red)
      else
        workspace.show_details
      end
    when "6", "send message"
      print "Please enter in a message to send: ".colorize(:yellow)
      message = gets.chomp
      sending_message = workspace.send_message(message)
      if sending_message == false
        puts "--- No channel or user selected. ----".colorize(:light_red)
      elsif sending_message == nil
        puts "--- Invalid message, unable to send. ---".colorize(:light_red)
      else puts "--- Message sent succesfully! ---".colorize(:blue)       end
    when "7", "quit"
      puts "Thank you for using the Ada Slack CLI".colorize(:magenta)
      exit
    end # end
  end
end

# end

main if __FILE__ == $PROGRAM_NAME
