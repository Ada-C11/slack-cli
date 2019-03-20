#!/usr/bin/env ruby
require_relative "user"
require_relative "channels"
require "table_print"

Dotenv.load

# module Slack
def main
  users = Slack::User
  channel = Slack::Channel
  
  puts "Welcome to the Ada Slack CLI!"
  selection = 1
  while selection != 3
    puts "#{users.list.length} users and #{channel.list.length} channels were uploaded.\n\n"

  puts "Please make a selection:\n"
  puts "1. list users\n"
  puts "2. list channels\n"
  puts "3. select user\n"
  puts "4. select channel\n"
  puts "5. details\n"
  puts "6. quit\n"
  
  selection = gets.chomp.to_i

  if selection == 1
    # users.list.each do |user| user.real_name
    tp users.list, "slack_id", "name", "real_name"
  elsif selection == 2
    tp channel.list, "slack_id", "name", "topic", "member_count"
  elsif selection == 3
    puts "Thank you for using the Ada Slack CLI"
    exit
  end # end
  end
end

# end

main if __FILE__ == $PROGRAM_NAME
