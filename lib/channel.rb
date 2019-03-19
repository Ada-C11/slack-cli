require "dotenv"
require "httparty"

Dotenv.load

class Channel #< Recipient
  BASE_URL = "https://slack.com/api/channels.list"
  key = ENV["SLACK_API_TOKEN"]

  query_parameters = {'token': key}

  def get(url, parameters)
    response = HTTParty.get(url, query: parameters)
  end

  def list
    puts "Here are a list of your channels for this Workspace:"
    response["channels"].each do |channel|
      puts channel["name"]
    end
  end
end
