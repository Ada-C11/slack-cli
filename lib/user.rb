require 'httparty'
require 'pry'
require_relative 'recipient.rb'

class User < Recipient
  
  attr_reader :real_name
  
  def initialize
    super(slack_id, name)
    @real_name
  end
  
  def self.get(url, params)
    url = "https://slack.com/api/users.list"
    params =  {
      token: KEY,
    }
    @response = HTTParty.get(url, query: params)
  end
  
  def self.list   
    return @response["members"].each { |member| puts member["name"] }
  end

end