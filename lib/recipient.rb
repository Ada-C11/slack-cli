module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    def post_message(message)
      url = "https://slack.com/api/chat.postMessage"
      params = {
        token: ENV["KEY"],
        channel: @slack_id || @name,
        text: message,
      }

      message_request = HTTParty.post(url, query: params)
      if message_request["ok"] == false
        raise ArgumentError, "Request is unsuccessful"
      else
        return message_request
      end
    end

    # def self.get(url, params)
    #   HTTParty.GET(url, query: params)
    # end

    def self.list_all
      raise NotImplementedError, "Please implement in my child."
    end
  end
end
