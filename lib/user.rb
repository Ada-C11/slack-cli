require "dotenv"
require "httparty"
Dotenv.load

class User
  attr_accessor :username, :real_name, :user_info, :id
  BASE_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_API_TOKEN"]

  def initialize(real_name, username, id)
    @username = username
    @real_name = real_name
    @id = id
    @user_info = User.get
  end

  def self.get
    query = {
      token: TOKEN,
    }
    @user_info = HTTParty.get(BASE_URL, query: query)
    if @user_info["ok"] == false
      raise ArgumentError, "The error code is #{user_info.code} and the reason is: #{user_info.message}"
    end
    return @user_info
  end

  def self.list
    user_info = User.get
    user_list = user_info["members"]
    users = user_list.map do |user|
      User.new(user["real_name"], user["name"], user["id"])
    end
    return users
  end
end
