require "pry"
require "httparty"

module SlackAPI
  class SlackError < StandardError; end

  class User
    #   attr_accessor :list_users, :user_list

    #   def initialize
    #     @user_list = {}
    #   end

    BASE_URL = "https://slack.com/api/users.list"

    def self.list_users
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(BASE_URL, query: query)

      user_list = {}

      if response["ok"]
        response["members"].each do |member|
          user_list[member["name"]] = {"real name" => member["real_name"], "slack id" => member["id"]}
          # binding.pry
        end
      else
        raise SlackAPI::SlackError, "There was an error. The code is #{response.error}."
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
      if selected_user == ""
        raise SlackAPI::SlackError, "That is not a valid user"
      end
      return selected_user
    end

    def see_details(identifier)
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(BASE_URL, query: query)

      user_details = {}

      # if response["ok"] != true
      #   raise SlackAPI::SlackError, "There was an error." # add error message later
      # else
      response["members"].each do |member|
        if member["id"] == identifier || member["name"] == identifier
          user_details[member["name"]] = {"real name" => member["real_name"], "slack id" => member["id"]}
          return user_details
        end
      end
    end
  end # end of class
end # end of module
