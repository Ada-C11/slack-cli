require_relative "recipient"

module SlackCLI
  class User < Recipient
    attr_reader :real_name

    def initialize(slack_id:, name:, real_name:)
      super(slack_id: slack_id, name: name)

      @real_name = real_name
    end
  end
end
