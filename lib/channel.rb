require 'httparty'

class Channel < Recipient
  
  attr_reader :topic, :member_count
  
  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  
  
  def self.list
    return self.get('channels.list')
  end
  
  private
  def self.create_from_api_response(channel)
    name = channel["name"]
    topic = channel["topic"]
    slack_id = channel["id"]
    member_count = channel["members"].count
      
    self.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count)   
  end
  
  
end