require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI
  class Channel
    BASE_URL = "https://slack.com/api/channels.list"

    attr_reader :slack_id, :name, :topic, :members

    def initialize(id, channel_name, topic, members)
      @slack_id = id
      @name = channel_name
      @topic = topic
      @members = members
    end

    def self.get_from_api
      query_parameters = {
        token: ENV["OAUTH_ACCESS_TOKEN"],
      }

      response = HTTParty.get(BASE_URL, query: query_parameters)
      if (response.code == 200)
        channels = response["channels"].map do |channel|
          slack_id = channel["id"]
          channel_name = channel["name"]
          topic = channel["topic"]["value"]
          members = channel["members"].length
          new(slack_id, channel_name, topic, members)
        end
        return channels
      else
        raise SlackApiError, "Error #{response.code} : #{response["message"]}"
      end
    end
  end
end
