require_relative "recipient"

class Channel < Recipient
  attr_reader :slack_id, :name, :topic, :member_count
  LIST_URL = "https://slack.com/api/channels.list"

  def initialize(slack_id:, name:, topic:, member_count:)
    @slack_id = slack_id
    @name = name
    @topic = topic
    @member_count
  end

  def self.list
    response = Channel.get

    channels = response["channels"].map do|channel| 
      slack_id = channel["id"]
      name = channel["name"]
      topic = channel["topic"]
      member_count = channel["num_member"]
      self.new(slack_id: slack_id, name: name, topic: topic, member_count: )
    end
      return list_of_channels
  end

  def details(name)
    return "#{name}, #{slack_id}, #{topic}, #{member_count}"
  end
end

