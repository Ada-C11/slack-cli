require_relative "recipient"
require_relative "user"
require_relative "channel"
require "dotenv"
require "httparty"
Dotenv.load
require "ap"

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "Choose from the following options:\n1. List users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Quit"
  choice = gets.chomp.upcase
  until choice == "QUIT"
    if choice == "LIST USERS"
      puts "\n"
      puts User.list
    elsif choice == "LIST CHANNELS"
      puts "\n"
      puts Channel.list
    elsif choice == "SELECT USER"
      puts "Please enter a username or Slack ID:"
      user_input = gets.chomp.upcase
    elsif choice == "SELECT CHANNEL"
      puts "Please enter channel name or Slack ID:"
      channel_input = gets.chomp.upcase
    elsif choice == "DETAILS"
      #call workspace.selected
      #if that's nil or empty, raise error
      #else call details method on selected
      #return details
    end
    puts "Choose from the following options:\n1. List users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Quit"
    choice = gets.chomp.upcase
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
