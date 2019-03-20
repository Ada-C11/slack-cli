#!/usr/bin/env ruby
require "httparty"
require "awesome_print"
require "dotenv"
Dotenv.load

def list_users
  url = "https://slack.com/api/users.list"
  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
  }

  response = HTTParty.get(url, query: query_parameters).to_s
  response = JSON.parse(response)

  response["members"].length.times do |i|
    puts response["members"][i]["name"]
    i += 1
    sleep 1
  end
end

def select_user
  puts "\nWhich user would you like to select?"
  selected_user = gets.chomp

  url = "https://slack.com/api/users.list"
  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
    user: "#{selected_user}",
  }

  response = HTTParty.get(url, query: query_parameters)

  response = JSON.parse(response.body)

  response["members"].length.times do |i|
    if response["members"][i]["name"].include? selected_user
      desired_id = response["members"][i]["id"]
      ap "You have selected #{response["members"][i]["name"]} with member ID #{desired_id}"
      return desired_id
    else
      i += 1
    end
  end
  ap "There is no user with that name."
end

def list_channels
  url = "https://slack.com/api/channels.list"
  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
  }

  response = HTTParty.get(url, query: query_parameters).to_s
  response = JSON.parse(response)

  response["channels"].length.times do |i|
    puts response["channels"][i]["name"]
    i += 1
    sleep 1
  end
end

def select_channel
  puts "\nWhich channel would you like to select?"
  selected_channel = gets.chomp

  url = "https://slack.com/api/channels.list"
  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
    user: "#{selected_channel}",
  }

  response = HTTParty.get(url, query: query_parameters)

  response = JSON.parse(response.body)

  response["channels"].length.times do |i|
    if response["channels"][i]["name"].include? selected_channel
      desired_id = response["channels"][i]["id"]
      ap "You have selected #{response["channels"][i]["name"]} with channel ID #{desired_id}"
      return desired_id
    else
      i += 1
    end
  end
  ap "There is no channel with that name."
end

def user_details(select_user)
  ap select_user
  url = "https://slack.com/api/users.profile.get"

  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
    user: select_user,
  }

  response = HTTParty.get(url, query: query_parameters)
  #response = JSON.parse(response.body)

  ap "#{response["profile"]}"
end

def channel_details(select_channel)
  url = "https://slack.com/api/channels.info"

  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
    channel: select_channel,
  }

  response = HTTParty.get(url, query: query_parameters)
  # response = JSON.parse(response.body)

  ap "#{response["channel"]}"
end

def send_message(id)
  puts "this is id", id
  puts "Please type the message you would like to send."
  message = gets.chomp

  url = "https://slack.com/api/chat.postMessage"

  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
    channel: id,
    text: message,
  # as_user: true, # still will not send with as_user enabled and only slackbot w/o it
  }

  response = HTTParty.post(url, query: query_parameters)
  #response = JSON.parse(response.body)

  puts response
  ap "Message sent!"
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
  puts "e. details for selected channel/user"
  puts "f. message channel/user"
  puts "g. quit"
  @response = gets.chomp.downcase.delete(".,")
end

continue = true

while (continue)
  main
  if @response == "a"
    puts "\nAll the users in the Slack workspace: \n\n"
    list_users
  elsif @response == "b"
    select_user
  elsif @response == "c"
    puts "\nAll the channels in the Slack workspace: \n\n"
    list_channels
  elsif @response == "d"
    select_channel
  elsif @response == "e"
    puts "\nWould you like details for (a) a user or (b) a channel?"
    puts "Please type a or b."
    select = gets.chomp
    if select == "a"
      user_details(select_user)
    elsif select == "b"
      channel_details(select_channel)
    else
      puts "Invalid selection."
    end
  elsif @response == "f"
    puts "\nWould you like to message (a) a user or (b) a channel?"
    puts "Please type a or b."
    select = gets.chomp
    if select == "a"
      send_message(select_user)
    elsif select == "b"
      send_message(select_channel)
    else
      puts "Invalid selection."
    end
  elsif @response == "g"
    puts "\nOkay, good-bye! Thank you for using the Ada Slack CLI \n\n"
    continue = false
  else
    puts "\nInvalid input. To quit, choose g."
    main
  end
end

# main if __FILE__ == $PROGRAM_NAME
