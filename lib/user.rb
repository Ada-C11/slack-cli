require "httparty"
require "pry"
require "dotenv"
Dotenv.load

# module SlackAPI
class User
  #   attr_accessor :list_users, :user_list

  #   def initialize
  #     @user_list = {}
  #   end

  BASE_URL = "https://slack.com/api/users.list"

  # class SlackError < StandardError; end

  def self.list_users
    query = {
      token: ENV["SLACK_API_TOKEN"],
    }

    response = HTTParty.get(BASE_URL, query: query)

    user_list = {}

    if response.code != 200
      raise ArgumentError, "There was an error. The code is #{response.error}."
    else
      response["members"].each do |member|
        user_list[member["name"]] = {"real name" => member["real_name"], "slack id" => member["id"]}
        # binding.pry
      end
    end
    return user_list
  end

  def select_user(identifier)
    query = {
      token: ENV["SLACK_API_TOKEN"],
    }

    response = HTTParty.get(BASE_URL, query: query)
    selected_user = ""
    response["members"].each do |member|
      if member["id"] == identifier
        selected_user = identifier
      elsif member["name"] == identifier
        selected_user = identifier
      end
    end
    return selected_user
  end


end # end of class

# end
