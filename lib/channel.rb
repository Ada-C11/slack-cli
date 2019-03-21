require 'httparty'

class Channel < Recipient
  
  attr_reader :topic, :member_count
  
  def initialize(name:, topic:, member_count:)
    @topic = topic
    @member_count = member_count
    @name = name
  end
  
  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    
    if response["ok"] == false
      raise SlackApiError, "API call failed with reason #{response["error"]}"
    end
    
    channels = response["channels"].map do |channel|
      name = channel["name"]
      topic = channel["topic"]
      member_count = channel["members"].count
      
      self.new(name: name, topic: topic, member_count: member_count)
    end
    return channels
  end
  
  def self.list
    
  end
  
end