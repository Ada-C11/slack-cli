require "httparty"
require "dotenv"

Dotenv.load

module SlackApi
  BASE_URL = "https://slack.com/api/chat.postMessage"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  class SlackApiError < StandardError; end

  def self.send_message(message, user)
    response = HTTParty.post(
      "#{BASE_URL}",
      headers: {"Content-Type" => "application/x-www-form-urlencoded"},
      body: {
        token: SLACK_TOKEN,
        text: message,
        channel: user,
      },
    )

    if response["ok"]
      return true
    else
      raise SlackApi::SlackApiError, "Error when posting #{message} to #{user}, error: #{response["error"]}"
    end
  end
end
