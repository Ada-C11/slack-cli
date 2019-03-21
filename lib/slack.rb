#!/usr/bin/env ruby
require_relative "workspace"
require_relative "user"

module SlackCLI
  class Main
    def self.main
      puts "Welcome to the Ada Slack CLI!"
      option = 0
      until option == 3
        puts "\n\n---Options---\n\n"
        puts "  1. List Users"
        puts "  2. List Channels"
        puts "  3. Quit"
        puts "\nPlease, choose one of the options available"
        option = gets.chomp.to_i
        if option != 3
          self.options(option)
        end
      end
      puts "Thank you for using the Ada Slack CLI"
      exit
    end

    def self.options(option)
      if option == 1
        self.list_users
      elsif option == 2
        self.list_channels
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
  end
end

SlackCLI::Main.main if $PROGRAM_NAME == __FILE__
