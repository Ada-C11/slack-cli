require "httparty"
require "dotenv"
require "awesome_print" 
require_relative "channel"
require_relative "user"

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "This workspace has #{Slack::Channel.list_channels.length} channels."
  puts "This workspace has #{Slack::User.list_users.length} users."

  loop do
    puts "\n\t\t~ MENU ~
   \t|1|::List Channels
   \t|2|::List Users
   \t|3|::Select User
   \t|4|::Select Channel
   \t|7|::Quit"
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
      name_or_id = gets.chomp

      chosen_user = Slack::User.select_user(name_or_id)
      ap chosen_user

      puts "Show additional details for #{name_or_id}? (Y/N)"
      choice = gets.chomp.downcase

      if choice == "y"
        ap chosen_user.show_details(name_or_id)
        # call show_details method and puts ap it
      end
    when 4
      puts "Please enter a channel name or channel id:"
      name_or_id = gets.chomp
      chosen_channel = Slack::Channel.select_channel(name_or_id)

      puts "Show additional details for #{name_or_id}? (Y/N)"
      choice = gets.chomp.downcase

      if choice == "y"
        ap chosen_channel.show_details(name_or_id)
      end
      # ap details
      # call show_details method and puts ap it

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
