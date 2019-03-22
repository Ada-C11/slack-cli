<<<<<<< HEAD
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
  puts "\nPlease Choose from the following options:\n1. List users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Quit".colorize(:color => :blue, :mode => :bold)
=======
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
>>>>>>> 6733aa60d702e0eb003afc10f1ba20b29e827684
  choice = gets.chomp.upcase

  until choice == "QUIT"
    if choice == "LIST USERS"
      puts "\n"
<<<<<<< HEAD
      tp work_space.users, "username", "real_name", "id"
    elsif choice == "LIST CHANNELS"
      puts "\n"
      tp work_space.channels, "channel_name", "id", "topic", "members"
    elsif choice == "SELECT USER"
      puts "Here is a list of users:".colorize(:color => :magenta)
      tp work_space.users, "username", "id"
      puts "Please enter an username or Slack ID:".colorize(:color => :blue, :mode => :bold)
      user_input = gets.chomp
      user_recipient = work_space.select_user(user_input)
    elsif choice == "SELECT CHANNEL"
      puts "Here is a list of channels:".colorize(:color => :magenta)
      tp work_space.channels, "channel_name", "id", "topic", "members"
      puts "Please enter channel name or Slack ID:".colorize(:color => :blue, :mode => :bold)
      channel_input = gets.chomp
      channel_recipient = work_space.select_channel(channel_input)
    elsif choice == "DETAILS"
      puts work_space.selected
      #call workspace.selected
      #if that's nil or empty, raise error
      #else call details method on selected
      #return details
    end
    puts "\nWhat would you like to do next?\n1. List users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Quit".colorize(:color => :blue, :mode => :bold)
    choice = gets.chomp.upcase
  end
  puts "Thank you for using the Ada Slack CLI".colorize(:color => :green, :mode => :bold)
=======
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
>>>>>>> 6733aa60d702e0eb003afc10f1ba20b29e827684
end

main if __FILE__ == $PROGRAM_NAME
