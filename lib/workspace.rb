# workspace
require_relative "user"
require_relative "channel"
require "terminal-table"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = users,
             @channels = channels,
    @selected = selected
  end

  def select_channel(channel)
    # takes channel as user input
  end

  def select_user(user)
    # takes user as user input
  end

  def show_details(selected_item)
    #puts selected_item.details
  end

  def send_message(selected_item)
    # puts "What would you like to say to #{selected_item}"
    # message = gets.chomp
    # selected_item.send_message("message")
  end
end

#driver code
def main
  puts "TatiHana Slack Channels loaded #{SlackCli::Channel.list.length} channels"
  puts "TatiHana Users loaded #{SlackCli::User.list.length} users"

  def options
    puts "Please choose one of the following options:
    - list users
    - list channels
    - select user
    - select channel
    - details
    - quit
    Enter your choice now:"
  end

  options
  choice = gets.chomp
  loop do
    case choice
    when "list users"
      puts SlackCli::User.list_users
    when "list channels"
      puts SlackCli::Channel.list_channels
    when "select user"
      puts "what user would you like to select?"
      selected_user = gets.chomp
      sought_user = SlackCli::Workspace.select_user(selected_user)
    when "select channel"
      selected_channel = gets.chomp
      sought_channel = SlackCli::Workspace.select_channel(selected_channel)
    when "details"
      # think about logic
    when "quit"
      puts "Thanks for checking out TatiHana! Bye bye..."
      exit
    else
      # add something here
    end
    options
    choice = gets.chomp
  end
end

main if __FILE__ == $0
