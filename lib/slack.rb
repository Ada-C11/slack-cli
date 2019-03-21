#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

require_relative 'recipient.rb'
require_relative 'user.rb'
require_relative 'channel.rb'
require_relative 'workspace.rb'


Dotenv.load

def main
######## MESSAGE TO USER #########  
current_session = Workspace.new

  puts "Welcome to the Ada Slack CLI!"
  puts "There are #{current_session.channels.length} channels in this workspace."
  puts "There are #{current_session.users.length} users in this workspace."
  puts "Choose your next adventure from the following options: \n
        1. list users \n
        2. list channels \n
        3. quit"
        
        user_selection = gets.chomp.downcase
    case user_selection
    when "1" || "list users" || "users"
      current_session.users.each { |user| puts user.name }
      main
    when "2" || "list channels" || "channels"
      current_session.channels.each { |channel| puts channel.name}
      main
    when "3" || "quit"
      exit
    end
      
    
  puts "Thank you for using the Ada Slack CLI"  
end



main if __FILE__ == $PROGRAM_NAME