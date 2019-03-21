require "pry"
require "httparty"
require_relative "recipient"

module SlackAPI
  class SlackError < StandardError; end

  class Channel < Recipient
    # def initialize()
    #   super("channels.list")
    # end

    BASE_URL = "https://slack.com/api/"

    def self.list_channels
      response = Recipient.get("channels.list")

      channel_list = {}

      if response["ok"] != true # write a test for this
        raise SlackAPI::SlackError, "There was an error. The code is #{response["error"]}."
      else
        response["channels"].each do |channel|
          channel_list[channel["name"]] = {"topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"]}
          # binding.pry
        end
      end
      return channel_list
    end

    def select_channel(identifier) # maybe in parent class?
      response = Recipient.get("channels.list")

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
      response = Recipient.get("channels.list")

      channel_details = {}

      if response["ok"] != true
        raise SlackAPI::SlackError, "This channel is not valid."
      else
        response["channels"].each do |channel|
          if channel["id"] == identifier || channel["name"] == identifier
            channel_details[channel["name"]] = {"topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"]}
            return channel_details
          end
        end
      end
    end
  end #end of class
end #end of module
