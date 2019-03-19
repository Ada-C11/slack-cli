require "dotenv"
require "httparty"

Dotenv.load

class User #< Recipient
  attr_reader :url, :key

  #   url = "https://slack.com/api/users.list"
  #   key = ENV["SLACK_API_TOKEN"]

  #   query_parameters = {'token': key}

  #   def get(url, parameters)
  #     response = HTTParty.get(url, query: parameters)
  #   end

  def self.list
    url = "https://slack.com/api/users.list"
    key = ENV["SLACK_API_TOKEN"]

    parameters = {'token': key}

    response = HTTParty.get(url, query: parameters)

    puts "Here are a list of your users for this Workspace:"
    response["members"].each do |member|
      puts "\nUsername: #{member["name"]}, Slack ID: #{member["id"]}, Real name: #{member["real_name"]}!"
    end
  end
end
