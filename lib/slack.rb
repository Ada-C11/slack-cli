#!/usr/bin/env ruby
require_relative "channel"
require_relative "user"
require_relative "workspace"

require "httparty"
require "dotenv"
require "awesome_print"
require "pry"

Dotenv.load

users = SlackCLI::User.get_from_api
channels = SlackCLI::Channel.get_from_api
new_workspace = SlackCLI::Workspace.new(users: users, channels: channels)

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "What would you like to do?"
  puts "Options: \nlist users \nlist channels \nquit"
  input == gets.chomp.downcase
  until (input == "quit")
    case "input"
    when "list users"
      puts workspace.display_users
    when "list channels"
      puts workspace.display_channels
    when "quit"
      break
    else
      puts "That wasn't one of the options!"
    end
  end
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
