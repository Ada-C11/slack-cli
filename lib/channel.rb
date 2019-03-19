require "dotenv"
require "httparty"
require "awesome_print"

require_relative "recipient"

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end

    #temp
    def self.list
      list = []

      url = "https://slack.com/api/channels.list"

      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(url, query: query_parameters)

      if response.code == 200
        response.parsed_response["channels"].each do |channel|
          slack_id = channel["id"]
          name = channel["name"]
          topic = channel["topic"]["value"]
          member_count = channel["num_members"]

          list << Slack::Channel.new(slack_id, name, topic, member_count)
        end
      else
        ap "#{response.code} #{response.message}"
      end
      return list
    end
  end
end
