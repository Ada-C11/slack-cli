# workspace
require_relative "user"
require_relative "channel"
require "terminal-table"

class Workspace
  attr_reader :users, :channels, :selected, :list_users, :list_channels

  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = selected
  end

  def select_channel(name)
    #  @selected = @channels.select { |channel| if channel.name == name || channel.slack_id == name } # test this
  end

  def select_user(user)
    # @selected = @users.select { |user| if user.name == name || user.slack_id == name } # test this
  end

  def show_details(selected_item)
    @selected.details
  end

  def send_message
    message = gets.chomp
    @selected.send_message(name: @selected.name, message: message)
  end

  def self.list_channels
    @channels.each do |channel|
      puts "Channel name: #{channel.name} ID: #{channel.slack_id} topic: #{channel.topic}, Member count:#{channel.member_count}"
    end
    return nil
  end

  def self.list_users
    @users.each do |user|
      puts "#{user.real_name} Slack ID: #{user.slack_id}"
    end
    return nil
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
    # selected = false
  end

  options
  choice = gets.chomp
  loop do
    case choice
    when "list users"
      puts SlackCli::Workspace.list_users
    when "list channels"
      puts SlackCli::Workspace.list_channels
    when "select user"
      puts "what user would you like to select?"
      selected_user = gets.chomp
      sought_user = SlackCli::Workspace.select_user(selected_user)
      # selected = true if sought_user != nil

    when "select channel"
      selected_channel = gets.chomp
      # sought_channel = SlackCli::Workspace.select_channel(selected_channel)
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
