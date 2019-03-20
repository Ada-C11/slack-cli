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
      puts "Here are a list of your users for this Workspace:"
      users_list.each do |user|
        puts "\nUsername: #{user["name"]}, Slack ID: #{user["id"]}, Real name: #{user["real_name"]}!"
      end
    end
  end
end
