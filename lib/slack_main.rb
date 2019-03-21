#!/usr/bin/env ruby

require "dotenv"
require "pry"
require "httparty"

require_relative "recipient"
require_relative "channel"
require_relative "user"
require_relative "workspace"

Dotenv.load

CHANNEL_URL = "https://slack.com/api/channels.list"
USER_URL = "https://slack.com/api/users.list"

def ask(prompt)
  print "#{prompt} > "
  input = gets.chomp
  return input
end

def menu
  puts "\nMENU"
  puts "1. List users"
  puts "2. List channels"
  puts "3. Quit"

  input = ask("What do you want to do?")
  return input
end

def main
  puts "Welcome to the Ada Slack CLI!"

  channels = Slack::Channel.list

  puts "\nHere's how many channels were loaded: #{channels.length}"

  users = Slack::User.list

  puts "\nHere's how many users were loaded: #{users.length}"


  selection = menu

  until selection == "3"
    if selection == "1"
      users = Slack::User.list
      puts "\nHere are the users:"
      users.each_with_index do |user, i|
        puts "#{i + 1}. name:#{user.real_name} --status:#{user.status_text} --emoji:#{user.status_emoji}"
      end

    elsif selection == "2"
      channels = Slack::Channel.list
      puts "\nHere are the channels:"
      channels.each_with_index do |channel, i|
        puts "#{i + 1}. name:#{channel.name.capitalize} --topic: #{channel.topic} --member count:#{channel.member_count} --channel id:#{channel.id}"
      end
    else
      puts "\nInvalid entry.  Please try again!"
    end

    selection = menu
  end

  puts "Thank you for using the Ada Slack CLI"
end

main
