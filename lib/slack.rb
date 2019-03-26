#!/usr/bin/env ruby
require_relative "channel"
require_relative "user"
require_relative "workspace"

require "httparty"
require "dotenv"
require "awesome_print"
require "colorize"

Dotenv.load

def set_main_menu_input
  puts "What would you like to do?".colorize(:yellow)
  puts "\nOptions: \n1.list users \n2.list channels \n3.select user \n4.select channel \n5.quit".colorize(:blue)
  input = gets.chomp.downcase
  return input
end

def set_selected_input
  puts "\nOptions: \ndetails \nsend message \nreturn to main menu".colorize(:blue)
  input = gets.chomp.downcase
  return input
end

def selected_loop(input, workspace)
  until (input == "return to main menu")
    case input
    when "details"
      puts workspace.show_details.colorize(:green)
    when "send message"
      puts "Type a message to send:".colorize(:blue)
      message = gets.chomp
      workspace.send_message(message)
    when "return to main menu"
      break
    else
      puts "That wasn't one of the options!".colorize(:red)
    end
    input = set_selected_input
  end
end

def main
  users = SlackCLI::User.get_from_api
  channels = SlackCLI::Channel.get_from_api
  workspace = SlackCLI::Workspace.new(users: users, channels: channels)

  puts "Welcome to the Ada Slack CLI!".colorize(:yellow)
  input = set_main_menu_input

  until (input == "quit")
    case input
    when "list users"
      workspace.display_users
    when "list channels"
      workspace.display_channels
    when "select user"
      puts "Enter username or slack id:".colorize(:yellow)

      name_or_id = gets.chomp
      workspace.select_user(name_or_id)

      input = set_selected_input
      selected_loop(input, workspace)
    when "select channel"
      puts "Enter channel name or id:".colorize(:blue)
      name_or_id = gets.chomp
      workspace.select_channel(name_or_id)

      input = set_selected_input

      selected_loop(input, workspace)
    when "quit"
      break
    else
      puts "That wasn't one of the options!".colorize(:red)
    end
    input = set_main_menu_input
  end

  puts "Thank you for using the Ada Slack CLI.".colorize(:yellow)
end

main if __FILE__ == $PROGRAM_NAME
