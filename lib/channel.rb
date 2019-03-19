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
  end
end

binding.pry
self.list