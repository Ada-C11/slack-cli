#!/usr/bin/env ruby
require_relative "workspace"
require_relative "user"
require_relative "channel"

require "colorize"
require "table_print"
require "httparty"
require "pry"
require "dotenv"
Dotenv.load

def main
  workspace = Slack::Workspace.new

  puts "Welcome to the Ada Slack CLI!"
  # TODO project
  loop do
    puts "What would you like to do next?"
    puts "[list users] [list channels] [select user] [select channel] [details] [send message] [quit]"
    print "> "

    user_input = gets.chomp

    case user_input.downcase
    when "list users"
      tp workspace.users, workspace.tp_user_options
    when "list channels"
      tp workspace.channels, workspace.tp_channel_options
    when "select user"
      print "User ID or Username > "
      input = gets.chomp
      puts workspace.select_user(input)
    when "select channel"
      print "Channel ID or Channel Name > "
      input = gets.chomp
      puts workspace.select_channel(input)
    when "details"
      puts "No recipient selected".red unless workspace.selected
      tp workspace.selected, workspace.tp_details_options
    when "send message"
      puts "Message > "
      input = gets.chomp
      workspace.send_message(input)
    end

    break if user_input == "quit"
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
