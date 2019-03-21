#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require "table_print"
Dotenv.load

# list users
# list channels
# quit
class Slack
  attr_reader :channels, :users

  def initialize()
    query_parameters = {
      token: ENV["SLACK_API_TOKEN"],
      pretty: 1,
    }
    url = "https://slack.com/api/conversations.list?"
    @channels = HTTParty.get(url, query: query_parameters)
    url2 = "https://slack.com/api/users.list?"
    @users = HTTParty.get(url2, query: query_parameters)
  end

  def lists_channels
    channels["channels"].each do |x|
      puts "name: #{x["name"]}"
      puts "topic: #{x["topic"]["value"]}"
      puts "number of members: #{x["num_members"]}"
      puts "slack id: #{x["id"]}"
    end
  end

  def lists_users
    users["members"].each do |x|
      puts "name: #{x["name"]}"
      puts "id: #{x["id"]}"
      puts "real name: #{x["real_name"]}"
    end
  end
end

def main
  puts "Welcome to the Kasey-Elle Slack CLI!"

  slack = Slack.new

  puts "there are #{slack.channels["channels"].length} channels and #{slack.users["members"].length}"

  def options
    puts "What should we do next? (list channels / list users / quit):"
    return gets.chomp.downcase
  end

  continue = true

  while (continue)
    response = options
    case response
    when "list channels"
      slack.lists_channels
    when "list users"
      slack.lists_users
    when "quit"
      continue = false
    end
  end
  # TODO project

  puts "Thank you for using the Kasey-Elle Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
