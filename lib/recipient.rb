require 'httparty'
require 'awesome_print'
require 'dotenv'
Dotenv.load

class Recipient
  attr_reader :is_user

  def initialize(slack_id, is_user)
    @slack_id = slack_id
    @is_user = is_user
  end

  def details(slack_id)
    if @is_user
      url = 'https://slack.com/api/users.list'
      query_parameters = {
        token: ENV['SLACK_API_TOKEN']
      }
    
      response = HTTParty.get(url, query: query_parameters).to_s
      response = JSON.parse(response)
  
      users = response["members"]

      users.each do |user|
        if user["id"] == @slack_id
          puts "Your selected user has the following details:"
          puts "Name: #{user["real_name"]}"
          puts "SlackID #{user["id"]}"
          puts "Username: #{user["name"]}"
        end
      end
    else
      url = 'https://slack.com/api/channels.list'
      query_parameters = {
        token: ENV['SLACK_API_TOKEN']
      }
      
      response = HTTParty.get(url, query: query_parameters).to_s
      response = JSON.parse(response)
      channels = response["channels"]

      channels.each do |channel|
        if channel["id"] == @slack_id
          puts "Your selected channel has the following details:"
          puts "Channel name: #{(channel["name"]).capitalize}"
          puts "Topic: #{channel["topic"]["value"]}"
          puts "Purpose: #{channel["purpose"]["value"]}"
        end
      end
    end
  end
end