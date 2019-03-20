require "pry"
require "httparty"

module SlackAPI
  class SlackError < StandardError; end

  class Channel
    # attr_accessor :list_channels, :channel_list

    # def initialize
    #   @channel_list = {}
    # end

    BASE_URL = "https://slack.com/api/channels.list"

    def self.list_channels
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(BASE_URL, query: query)

      channel_list = {}

      if response["ok"] != true # write a test for this
        raise SlackAPI::SlackError, "There was an error. The code is #{response["error"]}."
      else
        response["channels"].each do |channel|
          channel_list[channel["name"]] = { "topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"] }
          # binding.pry
        end
      end
      return channel_list
    end

    def select_channel(identifier)
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(BASE_URL, query: query)

      selected_channel = ""
      response["channels"].each do |channel|
        if channel["id"] == identifier
          selected_channel = identifier
        elsif channel["name"] == identifier
          selected_channel = identifier
        end
      end
      if selected_channel == ""
        raise SlackAPI::SlackError, "That is not a vaild channel"
      end
      return selected_channel
    end

    def see_details(identifier)
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(BASE_URL, query: query)

      channel_details = {}

      if response["ok"] != true
        raise SlackAPI::SlackError, "This channel is not valid."
      else
        response["channels"].each do |channel|
          if channel["id"] == identifier || channel["name"] == identifier
            channel_details[channel["name"]] = { "topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"] }
            return channel_details
          end
        end
      end
    end
  end #end of class
end #end of module
