require "httparty"
require "dotenv"
require "pry"
require "table_print"
require_relative "recipient"

Dotenv.load

module SlackCLI
  class User < Recipient
    BASE_URL = "https://slack.com/api/users.list"
    attr_reader :name, :real_name, :slack_id

    def initialize(name, real_name, slack_id)
      super(slack_id, name)
      @real_name = real_name
    end

    def self.get_from_api
      query_parameters = {
        token: ENV["OAUTH_ACCESS_TOKEN"],
      }

      response = get(BASE_URL, query_parameters)

      if (response.code == 200)
        users = response["members"].map do |member|
          name = member["name"]
          real_name = member["real_name"]
          slack_id = member["id"]
          new(name, real_name, slack_id)
        end
        return users
      else
        raise SlackApiError, "Error #{response.code} : #{response["message"]}"
      end
    end

    def display_details
      info_string = "\nSlack ID : #{slack_id}" +
                    "\nUsername : #{username}" +
                    "\nReal name : #{real_name}"
      return info_string
    end
  end
end
