require "dotenv"
require "httparty"

Dotenv.load

class User #< Recipient
    
  BASE_URL = "https://slack.com/api/users.list"
  key = ENV["SLACK_API_TOKEN"]

  query_parameters = {'token': key}

  def get(url, parameters)
    response = HTTParty.get(url, query: parameters)
  end

  def list
    puts "Here are a list of your users for this Workspace:"
    response["members"].each do |member|
      puts member["name"]
    end
  end
end
