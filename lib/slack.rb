#!/usr/bin/env ruby
# require_relative "../spec/test_helper"
require_relative "channel"
require_relative "user"
require_relative "recipient"
require "dotenv"
require "httparty"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  channels = Slack::Channel.list_all
  name_channels = channels.map do |channel|
    channel.name
  end

  # puts name_channels
  puts "Channels loaded: ", channels.length

  users = Slack::User.list_all
  name_users = users.map do |user|
    user.name
  end

  # puts name_users
  puts "Users loaded: ", users.length

  puts "Please select from the following options: list_users, list_channels, or quit"

  # Should we use a case statement here for the 3 options?

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
