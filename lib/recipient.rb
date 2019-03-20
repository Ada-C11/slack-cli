require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

module Slack
  class Recipient
    # class ResponseError < StandardError; end

    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url, params)
      user_data = HTTParty.get(url, query: params)

      if user_data["ok"] == false
        raise ArgumentError, "There was an error!\nCode: #{user_data.code} Message: #{user_data.message}"
      end
      # unless response.code == 200
      #   raise SearchError, "Cannot find #{search_term}"
      # end

      return user_data
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
