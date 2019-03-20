require_relative "recipient"
require 'pry'
require "dotenv"
require "httparty"

Dotenv.load

module Slack
  class Channel < Recipient
    def initialize(topic:, member_count:)
      @topic = topic
      @member_count = member_count
    end

    CHANNEL_URL = "https://slack.com/api/channels.list"


    def details

      # list details for a specific channel

    end

    def self.list
      query_params = { token: ENV["SLACK_API_TOKEN"] }
    
      response = Slack::Channel.get(CHANNEL_URL, query_params)
      channels = response["channels"]
      channels.each do |channel|
        puts channel["name"] 
        puts channel["id"]
        puts channel["topic"]["value"]
        puts channel["members"].count
      end
    end
    puts Slack::Channel.list
  end
end

# query_params = { token: ENV["SLACK_API_TOKEN"] }
