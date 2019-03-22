#!/usr/bin/env ruby

require_relative "user"
require_relative "channel"
require_relative "workspace"

Dotenv.load

def main
  workspace = SlackApi::Workspace.new

  user_options = "list users\nlist channels\nselect user\nselect channel\ndetails\nsend message\nquit"

  puts "Welcome to the Ada Slack CLI!"
  puts "\nThere are #{workspace.channels.length} channels and #{workspace.users.length} users in this Workspace."
  puts "\nWhat would you like to do?:"
  puts user_options

  user_selection = gets.chomp
  until user_selection == "quit"
    case user_selection
    when "list users"
      puts SlackApi::User.list(workspace.users)
    when "list channels"
      puts SlackApi::Channel.list(workspace.channels)
    when "select user"
      print "\nEnter username or user's ID: "
      user_input = gets.chomp
      if workspace.select_user(user_input) != true
        puts "\n~That user does not exist~"
      end
    when "select channel"
      print "\nEnter channel name or channel's ID: "
      user_input = gets.chomp
      if workspace.select_channel(user_input) != true
        puts "\n~That channel does not exist~"
      end
    when "details"
      puts workspace.show_details
    when "send message"
      puts "\n(This will send to the recipient you have selected)"
      print "What message would you like to send? "
      user_message = gets.chomp
      workspace.send_message(user_message)
    end

    puts "\nWhat would you like to do next?"
    puts user_options
    user_selection = gets.chomp
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
