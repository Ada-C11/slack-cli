#!/usr/bin/env ruby
require_relative "channel"
require "httparty"
require "dotenv"
require "awesome_print"
require "pry"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
