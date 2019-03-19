module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize
      @slack_id = slack_id
      @name = name
    end

    def self.list_all(slack_id)
      raise NotImplementedError, "Please implement in my child."
    end
  end
end
