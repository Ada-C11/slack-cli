require 'pry'

require_relative 'recipient'

class User < Recipient 
  LIST_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_TOKEN"]

  attr_reader :real_name

  def initialize
    @real_name = real_name
    @status_text = status_text 
    @status_emoji = status_emoji
  end

  def self.list
    # calls self.get from parent
    # receives user payload
    # iterate through payload to store in array
    # return array
    response = User.get

    user_list = response["members"].map do |user|
      user["name"]
    end

    binding.pry
  end
end

puts User.list