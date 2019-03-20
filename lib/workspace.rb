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
   |2|::Channel Details
   |3|::List Users
   |4|::User Details
   |5|::Select Channel
   |6|::Select User
   |7|::Quit"

    answer = gets.chomp.to_i

    # List Stuff
    case answer

    when 1
      ap Slack::Channel.list_channels
    when 2
    when 3
      ap Slack::User.list_users
    when 4
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
