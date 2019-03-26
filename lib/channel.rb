require "httparty"
require "dotenv"
require_relative "recipient"

Dotenv.load

module SlackCLI
  class Channel < Recipient
    BASE_URL = "https://slack.com/api/channels.list"

    attr_reader :topic, :members

    def initialize(slack_id, name, topic, members)
      super(slack_id, name)
      @topic = topic
      @members = members
    end

    def self.get_from_api
      query_parameters = {
        token: ENV["OAUTH_ACCESS_TOKEN"],
      }

      response = get(BASE_URL, query_parameters)

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

    def display_details
      info_string = "\nSlack ID : #{slack_id}" +
                    "\nChannel name : #{name}" +
                    "\nTopic : #{topic}" +
                    "\nMember count: #{members}"
      return info_string
    end
  end
end
