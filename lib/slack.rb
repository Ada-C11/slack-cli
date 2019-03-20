#!/usr/bin/env ruby
require_relative "user"
require "table_print"

Dotenv.load

# module Slack
def main
  users = Slack::User

  puts "Welcome to the Ada Slack CLI!"
  puts "#{users.list.length} users and #{"PUT IN CHANNELS"} channels were uploaded.\n\n"

  puts "Please make a selection:\n1. list users\n2. list channels\n3. quit\n\n"
  selection = gets.chomp.to_i

  # tp Author.limit(3), "name", "books.title", "books.photos.caption"
  if selection == 1
    # users.list.each do |user| user.real_name
    tp users.list, "slack_id", "name", "real_name"
    # end
  elsif selection == 3
    exit
  end

  puts "Thank you for using the Ada Slack CLI"
end

# end

main if __FILE__ == $PROGRAM_NAME
