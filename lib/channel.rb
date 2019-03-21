require "HTTParty"
require "dotenv"
require "awesome_print"

module Slack
  class Channel
    CHANNEL_URL = "https://slack.com/api/channels.list"

    class SlackError < StandardError; end

    Dotenv.load

    attr_reader :channel_id, :channel_name, :topic, :member_count
    attr_accessor :channel_name, :topic

    # def initialize(channel_id, channel_name, topic)
    #   @channel_id = channel_id
    #   @channel_name = channel_name
    #   @topic = topic
    #   @member_count = member_count
    # end # initialize

    def self.list_channels
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }
      response = HTTParty.get(CHANNEL_URL, query: query_parameters)
      ENV["SLACK_API_TOKEN"]

      slack_channels = {}
      if (response.code == 200)
        passes = response["channels"].map do |channel|
          slack_channels[channel] = { "name" => channel["name"],
                                     "members" => channel["members"].length,
                                     "topic" => channel["topic"] }
        end
      else
        puts "Error #{response.code} : #{response["message"]}"
      end # else
      return passes
    end # self.list

    def select_channel(id)
      chosen_channel = ""

      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }
      response = HTTParty.get(CHANNEL_URL, query: query_parameters)

      response["channels"].each do |channel|
        if channel["id"] == id
          chosen_channel = id
        elsif channel["name"] == id
          chosen_channel = id
        end

        if chosen_channel == ""
          raise SlackError, "channel must have an id or a name."
        end # end
      end # each
      return chosen_channel
    end # self.select_channel

    def show_details(id)
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }
      response = HTTParty.get(CHANNEL_URL, query: query_parameters)

      # query token
      # response
      # create a hash and iterate over channel details. put result in hash and return it
    end

    # ap self.channel_api_data
    # ap self.list_channels

    # added another file for the recipient?
    # make some conditionals dependant on response code?

    
  end # class
end # module