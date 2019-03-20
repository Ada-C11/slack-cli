require_relative "recipient"

module Slack
  class Channel < Recipient
    URL = "https://slack.com/api/channels.list"
    PARAM = {token: ENV["KEY"]}

    # puts 'ENV["KEY"]', ENV["KEY"]

    attr_reader :topic, :member_count

    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @name = name
      @topic = topic
      @member_count = member_count
    end

    def self.list
      json_data = self.get(URL, PARAM)

      json_data["channels"].map do |channel|
        self.new(channel["id"], channel["name"], channel["topic"]["value"], channel["members"].length)
      end
    end
  end
end

# ap Slack::User.get("https://slack.com/api/users.list", {token: ENV["KEY"]})
# # puts Slack::User.list(potato)
