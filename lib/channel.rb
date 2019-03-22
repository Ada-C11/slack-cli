require "httparty"
require "dotenv"
require_relative "recipient"

Dotenv.load

module SlackCLI
  class Channel < Recipient
    BASE_URL = "https://slack.com/api/channels.list".freeze

    attr_reader :topic, :members

    def initialize(id, name, topic, members)
      super(id, name)
      @topic = topic
      @members = members
    end

    def self.get(url, param)
      query = { token: param }
      response = HTTParty.get(url, query: query)
      response
    end

    def self.list(url, param)
      response = self.get(url, param)
    if response["ok"]
      channels = response["channels"].map do |channel|
        slack_id = channel["id"]
        channel_name = channel["name"]
        topic = channel["topic"]["value"]
        members = channel["members"].length
        self.new(slack_id, channel_name, topic, members)
      end
      channels
    else
      raise SlackApiError, "Error #{response.code} : #{response['message']}"
    end
    end

  def self.display
    info_string = "\nSlack ID : #{slack_id}" \
                  "\nChannel name : #{name}" \
                  "\nTopic : #{topic}" \
                  "\nMember count: #{members}"
    info_string
  end
  end
end