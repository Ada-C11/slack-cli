require "httparty"
require "dotenv"
require_relative "recipient"

Dotenv.load

module SlackCLI
  class Channel < Recipient
    URL = "https://slack.com/api/channels.list".freeze
    CHAT_URL = "https://slack.com/api/chat.postMessage".freeze
    KEY = ENV["SLACK_API_TOKEN"]

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
      response = get(url, param)
      raise StandardError, "Error #{response.code} : #{response['message']}" if response["ok"].nil?

      formatted_list = []
      channels = response["channels"].each do |channel|
        slack_id = channel["id"]
        channel_name = channel["name"]
        topic = channel["topic"]["value"]
        members = channel["members"].length
        formatted_list << new(slack_id, channel_name, topic, members)
      end
      formatted_list
    end

    def details
      info_string = "\nSlack ID : #{id}" +
                    "\nChannel name : #{name}" +
                    "\nTopic : #{topic}" +
                    "\nMember count: #{members}"
      info_string
    end

    def self.message(text, channel)
      response = HTTParty.post("#{CHAT_URL}",
        headers: { "Content-Type" => "application/x-www-form-urlencoded" },
        body: {
          token: KEY,
          channel: channel,
          text: text
        }
      )
      if response["ok"]
        return true
      else
        raise ArgumentError, "Error when sending  message to #{channel}."
      end
    end
  end
end
