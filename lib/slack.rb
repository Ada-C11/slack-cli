#!/usr/bin/env ruby
require_relative "workspace"
require_relative "user"
require_relative "channel"

# require_relative "../specs/test_helper"
require "table_print"
require "httparty"
require "pry"
require "dotenv"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  # TODO project
  loop do
    puts "What would you like to do next?"
    puts "[list users] [list channels] [quit]"
    print "> "

    user_input = gets.chomp

    case user_input.downcase
    when "list users"
      tp Slack::User.list, :name, :real_name, :slack_id
    when "list channels"
      tp Slack::Channel.list, :name, :topic, :member_count, :slack_id
    end

    break if user_input == "quit"
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
