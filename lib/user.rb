require 'httparty'
require 'pry'
require_relative 'recipient.rb'
require_relative 'slack_api_error.rb'
require_relative 'workspace.rb'

class User 

# < Recipient
  BASE_URL = "https://slack.com/api/"
  KEY = ENV["TOKEN"]  
  attr_reader :real_name
  
  
  def initialize(username:, real_name:, slack_id:)
    # super(slack_id, name)
    @username = username
    @real_name = real_name
    @slack_id = slack_id   
  end
  
  
  
  def self.list   
    return self.get('users.list')
  end
  
  private
  
  # Stays in User
  def self.create_from_api_response(member)
    username = member["name"]
    real_name = member["real_name"]
    slack_id = member["id"]
      
    self.new(username: username, real_name: real_name, slack_id: slack_id)
  end
  
  # Move to Recipient
  # Endpoint is somthing like 'users.list' or 'channels.list'
  def self.get(endpoint)
    url = BASE_URL + endpoint
    params = {
      token: KEY
    }
  
    response = HTTParty.get(url, query: params)
    
    if response["ok"] == false
      raise SlackApiError, "API call failed with reason #{response["error"]}"
    end
    
    return response["members"].map do |member|
      self.create_from_api_response(member)
    end
  end

end