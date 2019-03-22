#!/usr/bin/env ruby
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = Workspace.new
  input = ""

  while input != "quit"
    puts "Choose an option: 
    \n List users 
    \n List channels
    \n Select user 
    \n Select channel 
    \n Get details
    \n Send message 
    \n Quit"

    input = gets.chomp.downcase
    case input
    when "list users"
      puts workspace.print_details("users")
    when "list channels"
      puts workspace.print_details("channels")
    when "select user"
      print "Enter the user name or Slack ID: "
      input_user = gets.chomp
      workspace.select_user(input_user)
      if workspace.selected == nil
        puts "User not found"
      end
    when "select channel"
      print "Enter the channel name or Slack ID: "
      input_channel = gets.chomp
      workspace.select_channel(input_channel)
      if workspace.selected == nil
        puts "Channel not found"
      end
    when "details"
      if workspace.selected == nil
        puts "Please select a user or channel."
      else
        puts workspace.show_details
      end
    when "send message"
      if workspace.selected == nil
        puts "Please select a user or channel."
      else
        print "Enter your message: "
        text = gets.chomp
        workspace.send_message(text)
      end
    when "quit"
    else
      puts "Please select a option from the menu."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
