require_relative "recipient"

module SlackCLI
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: slack_id, name: name)

      @topic = topic
      @member_count = member_count
    end
  end
end