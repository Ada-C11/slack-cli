#!/usr/bin/env ruby
# require_relative "../spec/test_helper"
require_relative "channel"
require_relative "recipient"
require "dotenv"
require "httparty"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  channels = Slack::Channel.list_all.name

  puts channels

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
