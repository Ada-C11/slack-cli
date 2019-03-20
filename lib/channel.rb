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
  end
end
