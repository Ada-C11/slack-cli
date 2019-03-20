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
      ap Slack::Channel.list_channels
    when 2
      ap Slack::User.list_users
    when 3
      puts "Please enter a username or real name:"
      id = gets.chomp
      ap Slack::User.select_user(id)

      @new_user = Slack::User.new
      ap @new_user.list_users
    when 4
      # puts "Please enter a channel name or channel id:"
      # id = gets.chomp
      # ap Slack::Channel.select_channel(id)

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
