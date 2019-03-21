require "pry"
require "httparty"
require_relative "recipient"

module SlackAPI
  class SlackError < StandardError; end

  class User < Recipient
    BASE_URL = "https://slack.com/api/"

    def self.list_users
      response = Recipient.get("users.list")

      user_list = {}

      if response["ok"]
        response["members"].each do |member|
          user_list[member["name"]] = {"real name" => member["real_name"], "slack id" => member["id"]}
        end
      else
        raise SlackAPI::SlackError, "There was an error. The code is #{response.error}."
      end
      return user_list
    end

    def select_user(identifier)
      response = Recipient.get("users.list")

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
      response = Recipient.get("users.list")

      user_details = {}

      response["members"].each do |member|
        if member["id"] == identifier || member["name"] == identifier
          user_details[member["name"]] = {"real name" => member["real_name"], "slack id" => member["id"]}
          return user_details
        end
      end
    end
  end # end of class
end # end of module
