require "httparty"
require "dotenv"
require_relative "recipient"

Dotenv.load

module SlackCLI
  class Channel < Recipient
    URL = "https://slack.com/api/channels.list".freeze

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
      raise StandardError, "Error #{response.code} : #{response['message']}" if response["ok"].nil?
      formatted_list = []
      channels = response["channels"].each do |channel|
        slack_id = channel["id"]
        channel_name = channel["name"]
        topic = channel["topic"]["value"]
        members = channel["members"].length
        formatted_list << self.new(slack_id, channel_name, topic, members)
      end
      formatted_list
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