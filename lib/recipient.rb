require "httparty"

module SlackCLI
  class Recipient
    class SlackApiError < StandardError; end

    attr_reader :slack_id, :name

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

    def send_message(message)
      url = "https://slack.com/api/chat.postMessage"
      api_key = ENV["SLACK_API_TOKEN"]

      body = {
        token: api_key,
        text: message,
        channel: self.slack_id,
      }
      headers = {"Content-Type" => "application/x-www-form-urlencoded"}
      response = HTTParty.post(url, body: body, headers: headers)

      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when posting #{message} to #{self.slack_id}, error: #{response.parsed_response["error"]}"
      end

      return true
    end

    private

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end

    def details
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end
