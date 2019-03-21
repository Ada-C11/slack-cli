#!/usr/bin/env ruby
require_relative "channel"
require_relative "user"
require_relative "workspace"

require "httparty"
require "dotenv"
require "awesome_print"
require "pry"

Dotenv.load

def main
  users = SlackCLI::User.get_from_api
  channels = SlackCLI::Channel.get_from_api
  workspace = SlackCLI::Workspace.new(users: users, channels: channels)

  puts "Welcome to the Ada Slack CLI!"
  puts "What would you like to do?"

  puts "Options: \nlist users \nlist channels \nselect user \nselect channel \nquit"
  input = gets.chomp.downcase

  until (input == "quit")
    case input
    when "list users"
      workspace.display_users
    when "list channels"
      workspace.display_channels
    when "select user"
      puts "Enter username or slack id:"

      name_or_id = gets.chomp.downcase
      user = workspace.select_user(name_or_id)
      puts "Options: \ndetails \nsend message \nreturn to main menu"
      input = gets.chomp.downcase

      until (input == "return to main menu")
        case input
        when "details"
          puts workspace.show_details
        when "send message"
          puts "Type a message to send:"
          message = gets.chomp
          workspace.send_message(message)
        when "return to main menu"
          break
        end
        puts "Options: \ndetails \nsend message \nreturn to main menu"
        input = gets.chomp.downcase
      end
    when "select channel"
      puts "Enter channel name or id:"
      name_or_id = gets.chomp.downcase
      workspace.select_channel(name_or_id)
      puts "Options: \ndetails \nsend message \nreturn to main menu"
      input = gets.chomp.downcase
      until (input == "return to main menu")
        case input
        when "details"
          puts workspace.show_details
        when "send message"
          puts "Type a message to send:"
          message = gets.chomp
          workspace.send_message(message)
        when "return to main menu"
          break
        end
        puts "Options: \ndetails \nsend message \nquit"
        input = gets.chomp.downcase
      end
    when "quit"
      break
    else
      puts "That wasn't one of the options!"
    end
    puts "What would you like to do?"
    input = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
