require "dotenv"
Dotenv.load
require "table_print"
require "httparty"
require "colorize"
require_relative "workspace"
require_relative "user"
require_relative "channel"

def main
  work_space = Workspace.new
  puts "Welcome to the Ada Slack CLI!".colorize(:color => :blue, :mode => :bold)
  puts "\nPlease Choose from the following options:\n1. List Users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Send Message\n7. Quit".colorize(:color => :blue, :mode => :bold)
  choice = gets.chomp.upcase

  until choice == "QUIT"
    if choice == "LIST USERS"
      puts "\n"
      tp work_space.users, "username", "real_name", "id"
    elsif choice == "LIST CHANNELS"
      puts "\n"
      tp work_space.channels, "channel_name", "id", "topic", :members => {:width => 60}
    elsif choice == "SELECT USER"
      puts "Here is a list of users:".colorize(:color => :magenta)
      tp work_space.users, "username", "id"
      begin
        puts "Please enter a username or Slack ID:".colorize(:color => :blue, :mode => :bold)
        user_input = gets.chomp
        user_recipient = work_space.select_user(user_input)
      rescue ArgumentError
        puts "The username or SlackID is invalid."
      end
    elsif choice == "SELECT CHANNEL"
      puts "Here is a list of channels:".colorize(:color => :magenta)
      tp work_space.channels, "channel_name", "id", "topic", "members"
      begin
        puts "Please enter channel name or Slack ID:".colorize(:color => :blue, :mode => :bold)
        channel_input = gets.chomp
        channel_recipient = work_space.select_channel(channel_input)
      rescue ArgumentError
        puts "The channel name or SlackID is invalid."
      end
    elsif choice == "DETAILS"
      begin
        tp work_space.show_details
      rescue ArgumentError
        puts "There is no recipient selected. Please select a user or a channel."
      end
    elsif choice == "SEND MESSAGE"
      puts "Please enter your message below:"
      user_message = gets.chomp
      begin
        work_space.send_message(user_message)
      rescue ArgumentError
        puts "The message is invalid. Please try again."
      rescue NoMethodError
        puts "Message failed to send. Please select a recipient and try again."
      end
      puts "Your message was successfully sent to the recipient!"
    end
    puts "\nWhat would you like to do next?\n1. List Users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Send Message\n7. Quit".colorize(:color => :blue, :mode => :bold)
    choice = gets.chomp.upcase
  end
  puts "Thank you for using the Ada Slack CLI!".colorize(:color => :green, :mode => :bold)
end

main if __FILE__ == $PROGRAM_NAME
