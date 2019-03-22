require_relative "recipient"

module SlackCli
  class Channel < SlackCli::Recipient
    attr_reader :topic, :member_count
    def initialize(slack_id, name, topic, member_count)
      @slack_id = slack_id
      @name = name
      @topic = topic
      @member_count = member_count
    end

    def self.list_url
      return "https://slack.com/api/channels.list"
    end

    def self.list
      response = get
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
      deets = "Channel name: #{name} \nID: #{slack_id} \ntopic: #{topic}, \nMember count:#{member_count}\n"
      return deets
    end
  end
end
