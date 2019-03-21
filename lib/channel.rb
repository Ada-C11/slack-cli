require_relative "recipient"

<<<<<<< HEAD
# class Channel < Recipient
#   BASE_URL = "https://slack.com/api/channels.list"
#   TOKEN = ENV["SLACK_TOKEN"]

#   class SlackAPIError < StandardError; end

#   def initialize
#     super
#     @topic = topic
#     @member_count = member_count
#   end

#   #   def details
#   #   end

#   def self.list
#     query_params = {
#       token: TOKEN,
#     }
#     response = HTTParty.get(BASE_URL, query: query_params)
#     # responses = response["response"]

#     # if response.code != 200 || response == nil
#     #   raise SlackAPIError
#     # end

#     # responses.each do |pass|
#     #   puts "#{pass["topic"].to_s}"
#     #   puts "#{pass["members"].to_a}"
#     # end
#   end
# end

# puts Channel.list

# , "API call failed with code #{response.code} and reason '#{response["reason"]}"
=======
class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    return "#{name} #{topic} member count: #{member_count} slack id: #{slack_id}"
  end

  def self.list
    raw_data = self.get("channel")

    unless raw_data.code == 200
      raise SlackApiError, "Improper request: #{raw_data.message}"
    end
    channel_list = []
    channels = raw_data["channels"]

    channels.each do |channel|
      slack_id = channel["id"]
      name = channel["name"]
      topic = channel["topic"]["value"]
      member_count = channel["members"].count

      new_channel = Channel.new(slack_id, name, topic, member_count)
      channel_list << new_channel
    end
    return channel_list
  end
end
>>>>>>> 8f059c8f71fe014a17318c0ca080ae80445fd273
