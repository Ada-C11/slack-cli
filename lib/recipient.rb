module SlackCLI
  class Recipient
    CHAT_URL = "https://slack.com/api/chat.postMessage".freeze
    attr_reader :id, :name

    def initialize(id, name)
      @name = name
      @id = id
    end

    def self.get(url, params)
      HTTParty.get(url, query: params)
    end

    def send_message(message)
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
        channel: id,
        text: message
      }
      response = HTTParty.post(
        CHAT_URL,
        body: query_parameters,
        headers: { "Content-Type" => "application/x-www-form-urlencoded" }
      )

      response.code == 200 && response["ok"]
    end

    def display_details
      raise NotImplementedError, "Implement me from a child class!"
    end

    def self.get
      raise NotImplementedError, "Implement me from a child class!"
    end
  end
  end
