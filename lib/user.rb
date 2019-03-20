require 'httparty'
require 'pry'
require_relative 'recipient.rb'

class SlackApiError < StandardError; end
class User 

# < Recipient
  BASE_URL = "https://slack.com/api/"
  KEY = ENV["TOKEN"]

  
  attr_reader :real_name
  

  
  def initialize
    super(slack_id, name)
    @real_name
  end
  
  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    
    if response["ok"] == false
      raise SlackApiError, "API call failed with reason #{response["error"]}"
    end
    
    return response
  end
  
  def self.list   
    return @response["members"].each { |member| puts member["name"] }
  end

end