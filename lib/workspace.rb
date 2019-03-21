# workspace
require_relative "user"
require_relative "channel"
require "terminal-table"
require 'pry'


class Workspace
  attr_reader :users, :channels, :selected, :list_users, :list_channels

  def initialize
    @users = SlackCli::User.list
    @channels = SlackCli::Channel.list
    @selected = selected
  end

  def select_channel(name)
    @selected = @channels.find do |channel| 
      channel.name == name || channel.slack_id == name
    end
  end

  def select_user(name)
    @selected = @users.find do |user| 
      user.name == name || user.slack_id == name
    end
  end

  def show_details
    @selected.details
  end

  def send_messagea # wrong number of arguments bug?
    message = gets.chomp
    @selected.send_message(name: @selected.name, message: message)
  end

  def list_channels
    @channels.each do |channel|
      puts "Channel name: #{channel.name} ID: #{channel.slack_id} topic: #{channel.topic}, Member count:#{channel.member_count}"
    end
    return nil
  end

  def list_users
    @users.each do |user|
      puts "#{user.real_name} Slack ID: #{user.slack_id}"
    end
    return nil 
  end
end

#driver code
def main
  workspace = Workspace.new
  puts "TatiHana Slack Channels loaded #{SlackCli::Channel.list.length} channels"
  puts "TatiHana Users loaded #{SlackCli::User.list.length} users"

  def options
    puts "Please choose one of the following options:
    - list users
    - list channels
    - select user
    - select channel
    - details
    - send message
    - quit
    Enter your choice now:"
    # selected = false
  end

  options
  choice = gets.chomp

  loop do
    case choice
    when "list users"
      puts workspace.list_users
    when "list channels"
      puts workspace.list_channels
    when "select user"
      puts "what user would you like to select?"
      selected_user = gets.chomp
      workspace.select_user(selected_user)
    when "select channel"
      puts "What channel would you like to select?"
      selected_channel = gets.chomp
      workspace.select_channel(selected_channel)
      puts "Channels selected: #{your_selection.name}"
    when "details"
      puts "Details for #{workspace.selected.name}..."
      workspace.show_details
    when "send message"
      puts "What would you like to send to #{workspace.selected.name}?"
      workspace.send_messagea # wrong number of arguments bug?
    when "quit"
      puts "Thanks for checking out TatiHana! Bye bye..."
      exit
    else
      puts "Invalid option! :("
    end

    options
    choice = gets.chomp
  end
end

main if __FILE__ == $0
