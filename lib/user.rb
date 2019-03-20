require "httparty"
require "dotenv"
require "pry"
require "table_print"

Dotenv.load

module SlackCLI
  class User
    BASE_URL = "https://slack.com/api/users.list"
    attr_reader :username, :real_name, :slack_id

    def initialize(username, real_name, slack_id)
      @username = username
      @real_name = real_name
      @slack_id = slack_id
    end

    def self.get_from_api
      query_parameters = {
        token: ENV["OAUTH_ACCESS_TOKEN"],
      }

      response = HTTParty.get(BASE_URL, query: query_parameters)

      if (response.code == 200)
        users = response["members"].map do |member|
          username = member["name"]
          real_name = member["real_name"]
          slack_id = member["id"]
          new(username, real_name, slack_id)
        end
        return users
      else
        puts "Error #{response.code} : #{response["message"]}"
      end
    end
  end
end
