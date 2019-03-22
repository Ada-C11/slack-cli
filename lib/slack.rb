#!/usr/bin/env ruby
require "pry"

require_relative "channel"
require_relative "user"
require "httparty"
require "dotenv"
Dotenv.load

class SlackError < StandardError; end

class Slack
  attr_reader :channels, :users

  def initialize()
    @channels = []
    @users = []
    poop
  end

  def poop()
    query_parameters = {
      token: ENV["SLACK_API_TOKEN"],
      pretty: 1,
    }
    url = "https://slack.com/api/conversations.list?"
    response = HTTParty.get(url, query: query_parameters)
    response["channels"].each do |x|
      @channels << Channel.new(x["name"], x["topic"]["value"], x["num_members"], x["id"])
    end
    url2 = "https://slack.com/api/users.list?"
    response2 = HTTParty.get(url2, query: query_parameters)
    response2["members"].each do |x|
      @users << User.new(x["name"], x["id"], x["real_name"])
    end
  end

  def lists_channels
    @channels.each do |x|
      x.details
    end
  end

  def lists_users
    @users.each do |x|
      x.details
    end
  end

  def select_user(search)
    raise SlackError, "please give valid search" if search == nil || search == ""
    user = @users.find { |x| x.user_name.downcase == search.downcase || x.user_id.downcase == search.downcase }
    raise SlackError, "no user found" if user == nil
    return user
  end

  def select_channel(search)
    raise SlackError, "please give valid search" if search == nil || search == ""
    channel = @channels.find { |x| x.name.downcase == search.downcase || x.slack_id.downcase == search.downcase }
    raise SlackError, "no channel found" if channel == nil
    return channel
  end
end

def main
  puts "Welcome to the Kasey-Elle Slack CLI!"

  slack = Slack.new

  puts "there are #{slack.channels.length} channels and #{slack.users.length} members"

  def options
    puts "What should we do next? (list channels/ list users/ select user/ select channel/ details/ quit):"
    return gets.chomp
  end

  continue = true

  chosen_user = ""
  while (continue)
    response = options
    case response
    when "list channels"
      slack.lists_channels
    when "list users"
      slack.lists_users
    when "select user"
      who = gets.chomp
      chosen_user = slack.select_user(who)
    when "select channel"
      who = gets.chomp
      chosen_user = slack.select_channel(who)
    when "send message"
      slack.send_msg
    when "details"
      # if chosen_user == ""
      #   puts "there is no selected user"
      #   options
      # end
      binding.pry
      chosen_user.details
    when "send message"
      slack.send_msg
    when "quit"
      continue = false
    end
  end
  # TODO project

  puts "Thank you for using the Kasey-Elle Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
