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
      tp workspace.users, :name, :real_name, :slack_id
    when "list channels"
      tp workspace.channels, :name, :topic, :member_count, :slack_id
    when "select user"
      print "User ID or Username > "
      input = gets.chomp
      puts "#{workspace.select_user(input)} selected".green
    when "select channel"
      print "Channel ID or Channel Name > "
      input = gets.chomp
      puts workspace.select_channel(input).green
    when "details"
      puts "No recipient selected".red unless workspace.selected

      if workspace.selected.class == Slack::User
        tp workspace.selected, :name, :real_name, :slack_id
      elsif workspace.selected.class == Slack::Channel
        tp workspace.selected, :name, :topic, :member_count, :slack_id
      end
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
