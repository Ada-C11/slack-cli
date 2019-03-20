#!/usr/bin/env ruby
require_relative "workspace.rb"

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = SlackCLI::Workspace.new
  puts "There are #{workspace.channels.count} channels in this workspace"
  puts "There are #{workspace.users.count} users in this workspace"

  puts "You can: List Users, List Channels, Select User, Select Channel, Details, or Quit."
  puts "Please enter what option you would like to take.  You can quit by entering 'quit'."
  response = gets.chomp.downcase
  while response != "quit"
    if response == "list users"
      list_users(workspace)
    elsif response == "list channels"
      list_channels(workspace)
    elsif response == "select user"
    elsif response == "select channel"
    elsif response == "details"
    else
      puts "Please make sure to select from the choices above. You can quit be entering 'quit'."
    end
    puts "\nPlease enter what you would like to do: \nList Users \nList Channels \nSelect User \nSelect Channel \nDetails \nQuit"
    response = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
end

def list_users(workspace)
  workspace.users.each do |user|
    puts "Slack ID: #{user.slack_id}, username: #{user.name}, real name: #{user.real_name}"
  end
end

def list_channels(workspace)
  workspace.channels.each do |channel|
    puts "Slack ID: #{channel.slack_id}, name: #{channel.name}, topic: #{channel.topic}, member count: #{channel.member_count}"
  end
end

main if __FILE__ == $PROGRAM_NAME
