require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url, params)
      response = HTTParty.get(url, query: params)
    end

    def details
    end

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end

# slack = Recipient.new
# slack.get("https://slack.com/api/channels.list", {token: ENV["KEY"]})

# puts slack
