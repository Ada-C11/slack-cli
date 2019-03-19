require "dotenv"
require "HTTParty"
require "pry"

Dotenv.load
KEY = ENV["SLACK_TOKEN"]

module Slack
  class SlackApiError < StandardError; end

  class Recipient
    def self.get(url, query:)
      response = HTTParty.get(url, query: query)
      if response["ok"] == false
        raise SlackApiError.new("Invalid request, error #{response.code}: #{response.message}")
      end
      return response
    end
  end
end

# query_params = {
#   token: "abcdef",
# }

# query_params2 = {
#   token: KEY,
# }

# response1 = Slack::Recipient.get(url: "https://slack.com/api/channels.list", query: query_params2)
# response2 = Slack::Recipient.get(url: "https://slack.com/api/channels.list", query: query_params)
# binding.pry
