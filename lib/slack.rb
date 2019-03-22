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
    user = @users.find { |x| x.user_name.downcase == search.downcase || x.user_id.downcase == search.downcase }
  end

  def select_channel(search)
    channel = @channels.find { |x| x.name.downcase == search.downcase || x.slack_id.downcase == search.downcase }
  end

  def self.send_msg(text, user)
    url = "https://slack.com/api/chat.postMessage"
    query_paramaters = {
      token: SLACK_API_TOKEN,
      channel: user,
      text: text,
    },
    response = HTTParty.post(url, query: query_paramaters, headers: {"Content-Type" => "application/x-www-form-urlencoded"})
    binding.pry
    if response["ok"]
      return true
    else
      raise SlackError, "Error when posting #{message} to #{channel}, error: #{response["error"]}"
    end
  end
end

def main
  puts "Welcome to the Kasey-Elle Slack CLI!"

  slack = Slack.new

  puts "there are #{slack.channels.length} channels and #{slack.users.length} members"

  def name_checker(who)
    while who == ""
      puts "please enter a valid name/id"
      who = gets.chomp
    end
  end

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
      name_checker(who)
      chosen_user = slack.select_user(who)
      puts "user not found, please try another selection" if chosen_user == nil
    when "select channel"
      who = gets.chomp
      name_checker(who)
      chosen_user = slack.select_channel(who)
      puts "channel not found, please try another selection" if chosen_user == nil
    when "send message"
      slack.send_msg
    when "details"
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
