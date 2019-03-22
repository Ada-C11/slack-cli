require "httparty"

module SlackCLI
  class Recipient
    class SlackApiError < StandardError; end

    attr_reader :slack_id, :name

    URL = "https://slack.com/api/chat.postMessage"
    API_KEY = ENV["SLACK_API_TOKEN"]

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url, params)
      response = HTTParty.get(url, query: params)
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when getting response, error: #{response.parsed_response["error"]}"
      end
      return response
    end

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end

    def details
      raise NotImplementedError, "Implement me in a child class!"
    end

    def send_message(message)
      body = {
        token: API_KEY,
        text: message,
        channel: self.slack_id,
      }
      headers = {"Content-Type" => "application/x-www-form-urlencoded"}
      response = HTTParty.post(URL, body: body, headers: headers)

      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when posting #{message} to #{self.slack_id}, error: #{response.parsed_response["error"]}"
      end

      return true
    end
  end
end
