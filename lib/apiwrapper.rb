module Slack
  module ApiWrapper
    class SlackError < StandardError; end

    URL_BASE = "https://slack.com/api/"
    TOKEN = ENV["SLACK_API_KEY"]

    def self.get_channels
      query_params = {
        "token": TOKEN,
      }
      response = HTTParty.get("#{URL_BASE}conversations.list", query: query_params)
      if !response["ok"]
        raise SlackError.new
      end
      return response
    end

    def self.get_users
      query_params = {
        "token": TOKEN,
      }
      response = HTTParty.get("#{URL_BASE}users.list", query: query_params)
      if !response["ok"]
        raise SlackError.new
      end
      return response
    end
  end
end
