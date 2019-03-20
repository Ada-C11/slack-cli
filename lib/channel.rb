require "dotenv"
require "httparty"

Dotenv.load

module SlackApi
  class SlackError < StandardError; end

  class Channel #< Recipient
    def self.channel_api
      url = "https://slack.com/api/channels.list"
      key = ENV["SLACK_API_TOKEN"]
      parameters = {'token': key}
      response = HTTParty.get(url, query: parameters).to_s
      response = JSON.parse(response)

      return response["channels"]
    end

    def self.list(channels_list)
      puts "Here are a list of your channels for this Workspace:"
      channels_list.each do |channel|
        puts "\nChannel name: #{channel["name"]}, Slack ID: #{channel["id"]}, Topic: #{channel["topic"]["value"]}, Member count: #{channel["num_members"]}!"
      end
    end
  end
end
