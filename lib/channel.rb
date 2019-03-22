require "HTTParty"
require "awesome_print"
require_relative "recipient"

module Slack
  class Channel < Recipient
    BASE_URL = "https://slack.com/api/channels.list"
    PARAMETERS = {token: ENV["SLACK_API_TOKEN"]}
  
    attr_reader :topic, :member_count

    def initialize(name, slack_id, topic, member_count)
      super(name, slack_id)
      @name = name
      @topic = topic
      @member_count = member_count
    end
   
    def self.list
      channel_data = self.get(BASE_URL, PARAMETERS)

      channel_data["channels"].map do |channel|
        self.new(channel["id"], channel["name"], channel["topic"]["value"], channel["members"].length)
      end
    end

    def show_details
      super.push("topic", "member_count")
    end
  end
end


# module Slack
#   class Channel
#     CHANNEL_URL = "https://slack.com/api/channels.list"

#     class SlackError < StandardError; end

#     Dotenv.load

#     attr_reader :channel_id, :channel_name, :topic, :member_count, :purpose

#     def initialize(channel_id:, channel_name:, topic:)
#       @channel_id = channel_id.to_s
#       @channel_name = channel_name
#       @topic = topic
#       @member_count = member_count
#     end # initialize

#     def self.get_channel_data
#       query_parameters = {
#         token: ENV["SLACK_API_TOKEN"],
#       }

#       response = HTTParty.get(CHANNEL_URL, query: query_parameters)

#       if response.code == 200
#         channel_data = response["channels"].map do |channel|
#           { channel_id: channel["id"],
#            channel_name: channel["name"],
#            topic: channel["topic"],
#            member_count: channel["members"].length }
#         end # map
#         return channel_data
#       else
#         raise Slack::SlackError, "There was an error. #{response.error}: #{response.message}"
#       end # end
#     end

#     # ap self.get_channel_data

#     def self.list_channels
#       channels = get_channel_data

#       return channels
#     end

#     def self.select_channel(name_or_id)
#       channel_data = get_channel_data

#       chosen_channel = nil

#       channel_data.each do |channel|
#         if channel[:channel_id] == name_or_id
#           chosen_channel = Slack::Channel.new(
#             channel_id: channel[:channel_id],
#             channel_name: channel[:channel_name],
#             topic: channel[:topic],
#           )
#         elsif channel[:channel_name] == name_or_id
#           chosen_channel = Slack::Channel.new(
#             channel_id: channel[:channel_id],
#             channel_name: channel[:channel_name],
#             topic: channel[:topic],
#           )
#         end
#       end

#       if chosen_channel == nil
#         raise Slack::SlackError, "There was an error. #{response.error}: #{response.message}"
#       end

#       return chosen_channel
#     end

#     def show_details(name_or_id)
#       channel_details = Channel.select_channel(name_or_id)

#       details = {
#         "Name" => channel_details.channel_name,
#         "Topic" => channel_details.topic["value"],
#       }
#       # details = channel_details.purpose
#       return details
#     end
#   end # class
# end # module
