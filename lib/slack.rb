require_relative "recipient"
require_relative "user"
require_relative "channel"

require "dotenv"
require "httparty"
Dotenv.load
require "ap"

def main
  puts "Welcome to the Ada Slack CLI!"

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
