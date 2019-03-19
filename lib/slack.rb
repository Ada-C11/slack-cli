#!/usr/bin/env ruby

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "The workspace has x channels and x users"
  ask_again = "Would you like to 'list users', 'list channels', or 'quit'?"
  puts ask_again
  response = gets.chomp

  until response == 'quit'
    if response == 'list users'
      #list user method (should see list of all users in workspace including username, real name, and slack id)
      puts ask_again
      response = gets.chomp
    elsif response == 'list channels'
      # list channel method (should see list of all channels in workspace including channel name, topic, member count and slack id)
      puts ask_again
      response = gets.chomp
    end
  end

  
end
# main if __FILE__ == $PROGRAM_NAME
