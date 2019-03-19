#!/usr/bin/env ruby

require "dotenv"
require "pry"
require "httparty"

require_relative "recipient"
require_relative "channel"
require_relative "user"
require_relative "workspace"

Dotenv.load

CHANNEL_URL = "https://slack.com/api/channels.list"
USER_URL = "https://slack.com/api/users.list"

def main
  puts "Welcome to the Ada Slack CLI!"
  # load an instance of workspace

  query_params = { token: ENV["SLACK_API_TOKEN"] }

  response1 = Slack::User.get(USER_URL, query_params)
  users = response1["members"]

  response2 = Slack::Channel.get(CHANNEL_URL, query_params)
  channels = response2["channels"]

  workspace = Slack::Workspace.new(users: users, channels: channels, selected: false)

  # Information about how many channels
  #puts workspace.channels
  # Info about how many users
  #puts workspace.users

  # 3 options to interact with program
  # list users
  # list channels
  # quit

  puts "Thank you for using the Ada Slack CLI"
end

# main if __FILE__ == $PROGRAM_NAME

# USER_URL = "https://slack.com/api/users.list"
# CHANNEL_URL = "https://slack.com/api/channels.list"

def get_recipient(type)
  query_params = { token: ENV["SLACK_API_TOKEN"] }
  if type == "user"
    return HTTParty.get(USER_URL, query: query_params)
  elsif type == "channels"
    return HTTParty.get(CHANNEL_URL, query: query_params)
  end
end
