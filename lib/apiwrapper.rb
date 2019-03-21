module Slack
  module ApiWrapper
    class SlackError < StandardError; end

    URL_BASE = "https://slack.com/api/"
    TOKEN = ENV["SLACK_API_KEY"]

    def self.get_channels
      url_tail = "channels.list"
      response = get_json(url_tail: url_tail)
      return response
    end

    def self.get_users
      url_tail = "users.list"
      response = get_json(url_tail: url_tail)
      return response
    end

    def self.get_json(url_tail:)
      query_params = {
        "token": TOKEN,
      }
      response = HTTParty.get("#{URL_BASE}#{url_tail}", query: query_params)
      if !response["ok"]
        raise SlackError.new
      end
      return response
    end

    def self.post(text:, recipient:)
      response = HTTParty.post(
        "#{URL_BASE}chat.postMessage",
        headers: { "Content-Type" => "application/x-www-form-urlencoded" },
        body: {
          token: TOKEN,
          channel: recipient,
          text: text,
        },
      )
      if response["ok"]
        return true
      else
        raise ApiWrapper::SlackError, "Error when posting #{text} to #{recipient}, error: #{response.parsed_response["error"]}"
      end
    end
  end
end
