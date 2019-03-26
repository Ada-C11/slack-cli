module SlackCLI
  class Recipient
    CHAT_ENDPOINT = "https://slack.com/api/chat.postMessage"
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @name = name
      @slack_id = slack_id
    end

    def self.get(url, params)
      return HTTParty.get(url, query: params)
    end

    def send_message(message)
      query_parameters = {
        token: ENV["OAUTH_ACCESS_TOKEN"],
        channel: slack_id,
        text: message,
      }
      response = HTTParty.post(
        CHAT_ENDPOINT,
        body: query_parameters,
        headers: { "Content-Type" => "application/x-www-form-urlencoded" },
      )

      return response.code == 200 && response.parsed_response["ok"]
    end

    def display_details
      raise NotImplementedError, "Implement me in a child class!"
    end

    def self.get_from_api
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end
