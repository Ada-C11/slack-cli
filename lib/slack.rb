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
    puts "6. quit\n\n".colorize(:light_red)

    selection = gets.chomp

    case selection
    when "1", "list users"
      tp workspace.users, "slack_id", :Name => {:display_method => "real_name"},
                                      :include => {:User_Name => {:display_method => "name"}}
    when "2", "list channels"
      tp workspace.channels, "name", "slack_id", "topic", "member_count"
    when "3", "select_user"
      print "Please enter in the user's USER_NAME or SLACK_ID: "
      user_descriptor = gets.chomp
      puts "\n#{workspace.select_user(user_descriptor)}".colorize(:red)
    when "4", "select channel"
      print "Please enter in the channel's NAME or SLACK_ID: "
      channel_descriptor = gets.chomp
      puts "\n#{workspace.select_channel(channel_descriptor)}".colorize(:red)
    when "5", "details"
      workspace.show_details
    when "6", "quit"
      puts "Thank you for using the Ada Slack CLI".colorize(:magenta)
      exit
    end # end
  end
end

# end

main if __FILE__ == $PROGRAM_NAME
