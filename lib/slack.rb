#!/usr/bin/env ruby
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new

  puts "Thank you for using the Ada Slack CLI"
end

# Make sure all user input gets checked/converted for casing issues (.upcase for usernames, etc.)

main if __FILE__ == $PROGRAM_NAME
