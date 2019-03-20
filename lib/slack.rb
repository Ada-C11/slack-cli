#!/usr/bin/env ruby
require_relative "workspace.rb"
def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = SlackCLI::Workspace.new
  puts "There are #{workspace.channels.count} channels in this workspace"
  puts "There are #{workspace.users.count} users in this workspace"
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
