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
  puts "3. Select user"
  puts "4. Select channel"
  puts "5. Details (on selected user/channel)"
  puts "6. Quit"

  input = ask("What do you want to do?")
  return input
end

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = Slack::Workspace.new

  puts "\nHere's how many channels were loaded: #{workspace.channels.length}"

  puts "\nHere's how many users were loaded: #{workspace.users.length}"

  selection = menu

  until selection == "6"
    if selection == "1"
      puts "\nHere are the users:"
      workspace.users.each_with_index do |user, i|
        puts "#{i + 1}. name:#{user.real_name} --status:#{user.status_text} --emoji:#{user.status_emoji}--slack_id:#{user.slack_id}--username:#{user.name}"
      end
    elsif selection == "2"
      puts "\nHere are the channels:"
      workspace.channels.each_with_index do |channel, i|
        puts "#{i + 1}. name:#{channel.name.capitalize} --topic: #{channel.topic} --member count:#{channel.member_count} --channel id:#{channel.slack_id}"
      end
    elsif selection == "3" || selection == "4"
      case selection
      when "3"
        identifier = ask("\nPlease enter an id or username")
        workspace.select_user(identifier)
        puts "You've selected this user: #{workspace.selected.name}"
      when "4"
        identifier = ask("\nPlease enter an id or channel name")
        workspace.select_channel(identifier)
        puts "You've selected this channel: #{workspace.selected.name}"
      end
    elsif selection == "5"
      workspace.show_details
    else
      puts "\nInvalid entry.  Please try again!"
    end

    selection = menu
  end

  puts "Thank you for using the Ada Slack CLI"
end

main
