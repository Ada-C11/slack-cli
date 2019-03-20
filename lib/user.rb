require_relative "recipient"
require "dotenv"
require "httparty"
Dotenv.load
require "pry"

class User
  attr_reader :topic, :member_count
  attr_accessor :user_names
  BASE_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_API_TOKEN"]

  def initialize
    @real_name = real_name
    @user_names = []
  end

  # self.get method to assign User object a @real_name

  def self.list
    query = {
      token: TOKEN,
    }
    user_info = HTTParty.get(BASE_URL, query: query)
    if user_info.code != 200
      raise ArgumentError, "The error code is #{user_info.code} and the reason is: #{user_info.message}"
    else
      user_list = user_info["members"]
      @user_names = user_list.map do |user|
        user["name"]
      end
      return @user_names
    end
  end
end
