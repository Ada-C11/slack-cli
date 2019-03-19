module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    def send_message(message)
      # Implement here.
    end

    def self.get(url, params)
      # Implement here.
    end

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end

    def details
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end
