
class Channel < Recipient
  def initialize(slack_id, name, topic, member_count)
    super
    @topic = topic
    @member_count = member_count
  end

  def details
  end

  def self.list
  end
end
