require 'httparty'

class Channel < Recipient
  
  attr_reader :topic, :member_count
  
  def initialize
    super(slack_id, name)
    @topic
    @member_count
  end
end