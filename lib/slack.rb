require_relative "recipient"
require_relative "user"
require_relative "channel"
require "pry"

require "dotenv"
require "httparty"
Dotenv.load
require "ap"

def main
  puts "Welcome to the Ada Slack CLI!"
  puts "Choose from the following options:\n1. List users\n2. List Channels\n3. Quit"
  choice = gets.chomp
  if choice == "1"
    puts User.list
  elsif choice == "2"
    puts Channel.list
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
