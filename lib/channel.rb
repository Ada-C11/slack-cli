require "pry"
require "httparty"
require_relative "recipient"

module SlackAPI
  class SlackError < StandardError; end

  class Channel < Recipient
    BASE_URL = "https://slack.com/api/"

    def self.list_channels
      response = Recipient.get("channels.list")

      channel_list = []

      if response["ok"] != true
        raise SlackAPI::SlackError, "There was an error. The error message is #{response["error"]}"
      else
        response["channels"].each do |channel|
          channel_list << { "name" => channel["name"], "topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"] }
        end
      end
      return channel_list
    end
  end #end of class
end #end of module
