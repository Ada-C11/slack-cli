require_relative "recipient"

module SlackCli
  class Channel < SlackCli::Recipient
    attr_reader :topic, :member_count, :list_channels
    LIST_URL = "https://slack.com/api/channels.list"
    MSG_URL = ""

    def initialize(slack_id, name, topic, member_count)
      @slack_id = slack_id
      @name = name
      @topic = topic
      @member_count = member_count
    end

    def self.list
      response = SlackCli::Channel.get

      channels = response["channels"].map do |channel|
        slack_id = channel["id"]
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["num_members"]
        self.new(slack_id, name, topic, member_count)
      end
      return channels
    end

    def self.list_channels
      list.each do |channel|
        puts "Channel name: #{channel.name} ID: #{channel.slack_id} topic: #{channel.topic}, Member count:#{channel.member_count}"
      end
      return nil
    end

    def details
      return "Channel name: #{name} \nID: #{slack_id} \ntopic: #{topic}, \nMember count:#{member_count}\n"
    end
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
