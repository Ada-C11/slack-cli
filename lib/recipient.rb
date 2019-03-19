module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    # Implemented
    def send_message(message)
    end

    def self.get(url, params)
      return HTTParty.get(url, query: params)
    end

    private

    # abstract

    def details
    end

    def self.list
    end
  end
end
