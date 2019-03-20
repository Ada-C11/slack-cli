require 'httparty'
require 'pry'
require_relative 'recipient.rb'
require_relative 'slack_api_error.rb'

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
  
  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    
    if response["ok"] == false
      raise SlackApiError, "API call failed with reason #{response["error"]}"
    end
    
    users = response["members"].map do |member|
      username = member["name"]
      real_name = member["real_name"]
      slack_id = member["id"]
      
      self.new(username: username, real_name: real_name, slack_id: slack_id)
    end
    return users
  end
  
  def self.list   
    # return @response["members"].each { |member| puts member["name"] }
    
  end

end