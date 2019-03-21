require "httparty"
require "dotenv"
require "awesome_print"
require "pry"
require_relative "channel"
require_relative "user"

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "\t\t\This workspace has #{Slack::Channel.list_channels.length} channels."
  puts "\t\t\This workspace has #{Slack::User.list_users.length} users."

  loop do
    puts "\n\t\t\.:Menu:.
   |1|::List Channels
   |2|::List Users
   |3|::Select User
   |4|::Select Channel
   |7|::Quit"
    puts "\nPlease select from the Menu:"
    answer = gets.chomp.to_i

    # List Stuff
    case answer

    when 1
      puts Slack::Channel.list_channels
      puts "Anything else?"
      answer = gets.chomp
    when 2
      puts Slack::User.list_users
      puts "Anything else?"
      answer = gets.chomp
    when 3
      puts "Please enter a username or real name:"
      id = gets.chomp
      user = Slack::User.new
      chosen_one = user.select_user(id)
      ap chosen_one
      # @new_user = Slack::User.new
      # ap @new_user.list_users
    when 4
      puts "Please enter a channel name or channel id:"
      id = gets.chomp
      channel = Slack::Channel.new
      chosen_channel = channel.select_channel(id)
      ap chosen_channel
      # @new_channel = Slack::Channel.new
      # ap @new_channel.list_channels
    when 5
    when 6
    when 7
      break
    else
      puts "Please select from Menu Items."
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME