#!/usr/bin/env ruby
require_relative "workspace"
require_relative "user"

module SlackCLI
  class Main
    def self.main
      puts "Welcome to the Ada Slack CLI!"
      option = 0
      until option == 5
        puts "\n\n---Options---\n\n"
        puts "  1. List Users"
        puts "  2. List Channels"
        puts "  3. Select User"
        puts "  4. Select Channels"
        puts "  5. Quit"
        puts "\nPlease, choose one of the options available"
        option = gets.chomp.to_i
        options(option) if option != 5
      end
      puts "Thank you for using the Ada Slack CLI\n\n"
      exit
    end

    def self.options(option)
      if option == 1
        list_users
      elsif option == 2
        list_channels
      elsif option == 3
        select_user
      elsif option == 4
        select_channel
      elsif option == 5
        exit
      end
    end

    def self.list_users
      workspace = Workspace.new
      users_list = workspace.users
      puts "\n\n----List of Slack Users----\n\n"
      users_list.each_with_index do |user, index|
        puts "User N.#{index + 1}"
        puts "  Name: #{user.name}"
        puts "  Real Name:#{user.real_name}"
        puts "  ID: #{user.id}\n\n"
      end
      puts "Press any key to continue...\n\n"
      gets.chomp
    end

    def self.list_channels
      workspace = Workspace.new
      channel_list = workspace.channels
      puts "\n\n----List of Slack Channels----\n\n"
      channel_list.each_with_index do |channel, index|
        puts "Channel N.#{index + 1}"
        puts "  Name: #{channel.name}"
        puts "  ID: #{channel.id}"
        puts "  Member Count: #{channel.members}"
        puts "  Topic: #{channel.topic}\n\n"
      end
      puts "Press any key to continue...\n\n"
      gets.chomp
    end

    def self.select_user
      puts "\n-> Type the id or name of the user " #####
      user = gets.chomp
      puts "\n\n---Recipient Options---\n\n"
      puts "  1. See Details"
      puts "  2. Send Message"
      puts "\nPlease, choose one of the options available"
      recipient_option = gets.chomp.to_i
      if recipient_option == 1
        users_details(user)
      elsif recipient_option == 2
        puts "\n\n-> Type away..."
        text = gets.chomp
        user_message(text, user)
      end
    end

    def self.select_channel
      puts "\n-> Type the id or name of the channel "
      channel = gets.chomp
      puts "\n\n---Channel Options---\n\n"
      puts "  1. See Details"
      puts "  2. Send Message"
      puts "\nPlease, choose one of the options available"
      recipient_option = gets.chomp.to_i
      if recipient_option == 1
        puts Workspace.new.channel_details(channel)
      elsif recipient_option == 2
        puts "\n\n-> Type away..."
        text = gets.chomp
        channel_message(text, channel)
      end
    end

    def self.users_details(user)
      begin
        details = Workspace.users_details(user)
        puts details
      rescue StandardError
        puts "\n\nThe user does not exist!"
      end
      puts "Press any key to continue...\n\n"
      gets.chomp
    end

    def self.user_message(text, user)
      begin
        status = Workspace.user_message(text, user)
        puts "\n\n---Message sucessfully sent!---" if status
      rescue StandardError
        puts "\n\nOops, something went wrong..."
        puts "To send a message you must provide the ID (while we improve this feature)"
        puts "Also, make sure you're choosing a valid user."
      end
      puts "Press any key to continue...\n\n"
      gets.chomp
    end

    def self.channel_message(text, channel)
      begin
        status = Workspace.channel_message(text, channel)
        puts "\n\n---Message sucessfully sent!---" if status
      rescue StandardError
        puts "\n\nOops, something went wrong..."
        puts "Also, make sure you're choosing a valid channel."
      end
      puts "Press any key to continue...\n\n"
      gets.chomp
    end
  end
end
SlackCLI::Main.main if $PROGRAM_NAME == __FILE__
