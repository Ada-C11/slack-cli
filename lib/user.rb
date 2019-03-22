require "pry"
require "httparty"
require_relative "recipient"

module SlackAPI
  class SlackError < StandardError; end

  class User < Recipient
    BASE_URL = "https://slack.com/api/"

    def self.list_users
      response = Recipient.get("users.list")

      user_list = []

      if response["ok"]
        response["members"].each do |member|
          user_list << {"name" => member["name"], "real name" => member["real_name"], "slack id" => member["id"]}
        end
      else
        raise SlackAPI::SlackError, "There was an error. The error message is #{response["error"]}"
      end
      return user_list
    end
  end # end of class
end # end of module
