require "dotenv"
require "httparty"

Dotenv.load

class Channel #< Recipient
  #   BASE_URL = "https://slack.com/api/channels.list"
  #   key = ENV["SLACK_API_TOKEN"]

  #   query_parameters = {'token': key}

  #   def get(url, parameters)
  #     response = HTTParty.get(url, query: parameters)
  #   end

  def self.list
    url = "https://slack.com/api/channels.list"
    key = ENV["SLACK_API_TOKEN"]

    parameters = {'token': key}

    response = HTTParty.get(url, query: parameters)

    puts "Here are a list of your channels for this Workspace:"
    response["channels"].each do |channel|
      puts "\nChannel name: #{channel["name"]}, Slack ID: #{channel["id"]}, Topic: #{channel["topic"]["value"]}, Member count: #{channel["num_members"]}!"
    end
  end
end
