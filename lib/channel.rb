require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count
  LIST_URL = "https://slack.com/api/channels.list"
  MSG_URL = ""

  def initialize(slack_id, name, topic, member_count)
    @slack_id = slack_id
    @name = name
    @topic = topic
    @member_count = member_count
  end

  def self.list
    response = Channel.get

    channels = response["channels"].map do |channel|
      slack_id = channel["id"]
      name = channel["name"]
      topic = channel["topic"]["value"]
      member_count = channel["num_members"]
      self.new(slack_id, name, topic, member_count)
    end
    return channels
  end

  def details
    return "Channel name: #{name} \nID: #{slack_id} \ntopic: #{topic}, \nMember count:#{member_count}\n"
  end
end

#add this to recipient?
# def send_message(message)
# query_params = {
#   token: TOKEN
#   name: self
#   message: message
# }
# response = HTTParty.post(self::MSG_URL, query: query_params)
#end
