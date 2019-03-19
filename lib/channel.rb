require "pry"

require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count 

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
  
  end

  def self.list 
    raw_data = self.get("channel")
    puts raw_data
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

binding.pry
self.list