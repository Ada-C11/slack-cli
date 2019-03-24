require_relative "recipient"
require_relative "apiwrapper"

module Slack
  class Channel < Recipient
    attr_reader :member_count, :topic

    def initialize(id:, name:, member_count:, topic:)
      super(id: id, name: name)
      @member_count = member_count
      @topic = topic
    end

    def details
      return "Name: #{name}, \nID: #{id}, \nTopic: #{topic}, \nMember Count: #{member_count}"
    end

    def self.create_channels
      channels = []
      begin
        response = ApiWrapper::get_channels
        response["channels"].each do |channel|
          channels << self.new(id: channel["id"],
                               name: channel["name"],
                               member_count: channel["num_members"],
                               topic: channel["topic"]["value"])
        end
      rescue ApiWrapper::SlackError
      end
      return channels
    end
  end
end
