require 'pry'

require_relative 'recipient'

class User < Recipient 
  LIST_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_TOKEN"]

  attr_reader :real_name, :list_users

  def initialize
    @real_name = real_name
    @status_text = status_text 
    @status_emoji = status_emoji
  end

  def self.list
    response = User.get
    return response
  end

  def self.list_users
    user_list = list["members"].map do |user|
      user["name"]
    end
    return user_list
  end
end

