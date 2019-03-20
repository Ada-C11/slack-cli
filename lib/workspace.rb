require "httparty"
require "dotenv"
require "awesome_print"
require "pry"
require_relative "channel"
require_relative "user"

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project
  puts "This workspace has #{Slack::Channel.list_channels.length} channels."
  puts "This workspace has #{Slack::User.list_users.length} users."

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
