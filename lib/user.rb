require "dotenv"
require "httparty"

Dotenv.load

module SlackApi
  class SlackError < StandardError; end

  class User #< Recipient
    def self.user_api
      url = "https://slack.com/api/users.list"
      key = ENV["SLACK_API_TOKEN"]
      parameters = {'token': key}
      response = HTTParty.get(url, query: parameters).to_s
      response = JSON.parse(response)

      return response["members"]
    end

    def self.list(users_list)
      puts "\nHere are a list of your users for this Workspace:"
      list_of_users = users_list.map do |user|
        "\nUsername: #{user["name"]}\nSlack ID: #{user["id"]}\nReal name: #{user["real_name"]}"
      end
      return list_of_users
    end
  end
end
