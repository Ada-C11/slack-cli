require_relative "recipient"
require_relative "user"
require_relative "channel"
require_relative "workspace"
require "dotenv"
require "httparty"
require "table_print"
Dotenv.load

def main
  slack = Workspace.new
  puts "Welcome to the Ada Slack CLI!"
  puts "Choose from the following options:\n1. List users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Quit"
  choice = gets.chomp.upcase

  until choice == "QUIT"
    if choice == "LIST USERS"
      puts "\n"
      tp slack.users
      puts "\n"
    elsif choice == "LIST CHANNELS"
      puts "\n"
      tp slack.channels
      puts "\n"
    elsif choice == "SELECT USER"
      puts "Please enter a username or Slack ID:"
      user_input = gets.chomp
      slack.select_user(user_input)
    elsif choice == "SELECT CHANNEL"
      puts "Please enter channel name or Slack ID:"
      channel_input = gets.chomp
      slack.select_channel(channel_input)
    elsif choice == "DETAILS"
      slack.show_details
    end

    puts "Choose from the following options:\n1. List users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Quit"
    choice = gets.chomp.upcase
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
