module Slack
  class SlackApiError < StandardError; end

    class Recipient
      attr_reader :slack_id, :name

      def initialize(slack_id:, name:)
        @slack_id = slack_id
        @name = name
      end

      BASE_URL = "https://slack.com/api/"

      # Helper method used in channel and user classes
      def self.get(url, params)
        return HTTParty.get(url, query: params)
      end

      # Helper method used by user and channel to send message
      def self.send_message(text, channel)
        body = {
          text: text,
          channel: channel,
          token: ENV["SLACK_API_TOKEN"],
        }

        response = HTTParty.post("#{BASE_URL}/chat.postMessage",
                                body: body,
                                headers: { "Content-Type" => "application/x-www-form-urlencoded" })

        return true
      end

      # Helper method used by user and channel to raise arg
      def error_message(message)
        unless response.code == 200 && response["ok"]
        raise SlackApiError, "#{message}"
      end

      # def send_message(message)

      # end

      private

      # abstract

      def details
        

      end

      def self.list
        result = get.()

      end
    end
  end
end
