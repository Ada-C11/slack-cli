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

  puts "Welcome to the Ada Slack CLI!"
  print "#{workspace.users.length} users and #{workspace.channels.length} "
  puts "channels were uploaded."

  selection = 1
  while selection != 6
    puts "\nPlease make a selection:\n\n"
    puts "1. list users"
    puts "2. list channels"
    puts "3. select user"
    puts "4. select channel"
    puts "5. details"
    puts "6. quit\n\n"

    selection = gets.chomp.to_i

    if selection == 1 || selection == "list users"
      puts ""
      tp workspace.users, "slack_id", :Name => {:display_method => "real_name"},
                                      :include => {:User_Name => {:display_method => "name"}}
    elsif selection == 2 || selection == "list channels"
      tp workspace.channels, "name", "slack_id", "topic", "member_count"
    elsif selection == 3 || selection == "select_user"
      print "Please enter in the user's USER_NAME or SLACK_ID: "
      user_descriptor = gets.chomp
      puts "\n#{workspace.select_user(user_descriptor)}".colorize(:red)
    elsif selection == 4 || selection == "select channel"
      print "Please enter in the channel's NAME or SLACK_ID: "
      channel_descriptor = gets.chomp
      puts "\n#{workspace.select_channel(channel_descriptor)}".colorize(:red)
    elsif selection == 5 || selection == "details"
    elsif selection == 6 || selection == "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    end # end
  end
end

# end

main if __FILE__ == $PROGRAM_NAME
