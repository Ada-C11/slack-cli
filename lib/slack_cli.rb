require "awesome_print"
require "table_print"
require_relative "workspace"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new
  # TODO project

  puts "This workspace has #{Slack::Channel.list.length} channels."
  puts "This workspace has #{Slack::User.list.length} users."

  loop do
    puts "\n\t\t~ MENU ~
   \t|1|::List Channels
   \t|2|::List Users
   \t|3|::Select User
   \t|4|::Select Channel
   \t|5|::Send Message
   \t|6|::Quit"
    puts "\nPlease select from the Menu:"
    answer = gets.chomp.to_i

    # List Stuff
    case answer
    when 1
      channel_list = Slack::Channel.list
      tp channel_list
    when 2
      user_list = Slack::User.list
      tp user_list
    when 3
      puts "Please enter a SlackID or full name:"
      name_or_id = gets.chomp

      channel_details = workspace.select_user(name_or_id)
      tp channel_details
      # selection = workspace.select_user(name_or_id)

      puts "Show additional details for #{name_or_id}? (Y/N)"
      choice = gets.chomp.downcase

      if choice == "y"
        puts "#{workspace.show_details}"
        # call show_details method and puts ap it
      end
    when 4
      puts "Please enter a channel name or channel id:"
      name_or_id = gets.chomp

      workspace.select_channel(name_or_id)

      puts "Show additional details for #{name_or_id}? (Y/N)"
      choice = gets.chomp.downcase

      if choice == "y"
        user_details = workspace.show_details
        tp user_details
      end
      # ap details
      # call show_details method and puts ap it
    when 5
      puts "What would you like to send to #{selection}?"
      message = gets.chomp
      recipient.send_message(recipient, message)
      puts "Your message has been sent! Yay!"
    when 6
      break
    else
      puts "Please select from Menu Items."
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
