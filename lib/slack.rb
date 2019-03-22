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
        puts "  4. Select Channel"
        puts "  5. Quit"
        puts "\nPlease, choose one of the options available"
        option = gets.chomp.to_i
        if option != 5
          self.options(option)
        end
      end
      puts "Thank you for using the Ada Slack CLI\n\n"
      exit
    end

    def self.options(option)
      if option == 1
        self.list_users
      elsif option == 2
        self.list_channels
      elsif option == 3
        self.select_user
      end
    end

    def self.list_users
      workspace = Workspace.new
      users_list = workspace.users_list
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
      # Code to list channels
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
        self.users_details(user)
      elsif recipient_option == 2
        puts "\n\n-> Type away..."
        text = gets.chomp
        self.user_message(text, user)
      end
    end

    def self.users_details(user)
      begin
        details = Workspace.users_details(user)
        puts details
      rescue
        puts "\n\nThe user does not exist!"
      end
      puts "Press any key to continue...\n\n"
      gets.chomp
    end

    def self.user_message(text, user)
      begin
        status = Workspace.user_message(text, user)
        if status
          puts "\n\n---Message sucessfully sent!---"
        end
      rescue
        puts "\n\nOops, something went wrong..."
        puts "To send a message you must provide the ID (while we improve this feature)"
        puts "Also, make sure you're choosing a valid user."
      end
      puts "Press any key to continue...\n\n"
      gets.chomp
    end
  end
end

SlackCLI::Main.main if $PROGRAM_NAME == __FILE__
