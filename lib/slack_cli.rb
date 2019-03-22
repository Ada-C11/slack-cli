require "awesome_print" 
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
      ap Slack::Channel.list
    when 2
      ap Slack::User.list
    when 3
      puts "Please enter a SlackID or full name:"
      name_or_id = gets.chomp

      puts "#{workspace.select_user(name_or_id)}"
      # selection = workspace.select_user(name_or_id)

      puts "Show additional details for #{name_or_id}? (Y/N)"
      choice = gets.chomp.downcase

      if choice == "y"
        selection.show_details
        # call show_details method and puts ap it
      end
    when 4
      puts "Please enter a channel name or channel id:"
      selection = gets.chomp

      workspace = Slack::Workspace.new
      recipient = workspace.select_channel(selection)

      puts "Show additional details for #{selection}? (Y/N)"
      choice = gets.chomp.downcase

      if choice == "y"
        recipient.show_details
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
