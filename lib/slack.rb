#!/usr/bin/env ruby
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = Workspace.new
  input = ""
  while input != "quit"
    puts "Choose an option: \n list users \n list channels \n \n select user \n select channel \n details \n \n send message \n quit"
    input = gets.chomp
    case input
    when "list users"
      puts workspace.print_details("users")
    when "list channels"
      puts workspace.print_details("channels")
    when "select user"
      print "Enter the user name or Slack ID: "
      input_user = gets.chomp
      workspace.select_user(input_user)
    when "select channel"
      print "Enter the channel name or Slack ID: "
      input_channel = gets.chomp
      workspace.select_channel(input_channel)
    when "details"
      if workspace.selected == nil
        puts "Please select a user or channel as a recipient"
      else
        puts workspace.show_details
      end
    when "send message"
      if workspace.selected == nil
        puts "Please select a user or channel as a recipient"
      else
        print "Enter your message: "
        text = gets.chomp
        workspace.send_message(text)
      end
    when "quit"
    else
      puts "Please select one of the options"
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
