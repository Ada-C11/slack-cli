#!/usr/bin/env ruby
require 'httparty'
require 'awesome_print'
require 'dotenv'
Dotenv.load


def list_users
  url = 'https://slack.com/api/users.list'
  query_parameters = {
    token: ENV['SLACK_API_TOKEN']
  }

  response = HTTParty.get(url, query: query_parameters).to_s
  response = JSON.parse(response)

  response["members"].length.times do |i|
    puts response["members"][i]["name"]
    i += 1
    sleep 1
  end
end


def list_channels
  url = 'https://slack.com/api/channels.list'
  query_parameters = {
    token: ENV['SLACK_API_TOKEN']
  }
  
  response = HTTParty.get(url, query: query_parameters).to_s
  response = JSON.parse(response)


  response["channels"].length.times do |i|
    puts response["channels"][i]["name"]
    i += 1
    sleep 1
  end
end


@response = ""


def main
  puts "Welcome to the Ada Slack CLI!"
  puts
  puts "What would you like to do? >"
  puts "a. list users"
  puts "b. select user"
  puts "c. list channels"
  puts "d. select channel"
  puts "e. details for selected user and channel"
  puts "f. quit"
  @response = gets.chomp.downcase.delete(".,")
end


continue = true 

while (continue)
  main
  if @response == "a"
    puts "\nAll the users in the Slack workspace: \n\n"
    list_users
  elsif @response == "b"
    # method call
  elsif @response == "c"
    puts "\nAll the channels in the Slack workspace: \n\n"
    list_channels
  elsif @response == "d"
    # method call
  elsif @response == "e"
    # method call
  elsif @response == "f"
    puts "\nOkay, good-bye! Thank you for using the Ada Slack CLI \n\n"
    continue = false
  else
    puts "\nInvalid input. To quit, choose c."
    main
  end
end



# main if __FILE__ == $PROGRAM_NAME