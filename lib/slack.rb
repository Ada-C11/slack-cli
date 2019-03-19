#!/usr/bin/env rub
require "dotenv"
def main
BASE_URL = 'https://slack.com/api/channels.list'
 SLACK_TOKEN = ENV["SLACK_TOKEN"]


  puts "Welcome to the Ada Slack CLI!"
 


  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME


