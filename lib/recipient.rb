module SlackAPI
  class Recipient

    attr_reader :slack_id, :name
    
    def initialize(slack_id:, name:)
        @slack_id = slack_id
        @name = name
    end

    def send_message(text:)
      body = {
        text: text,
        channel: slack_id,
        token: ENV["TOKEN"],
      }

      response = HTTParty.post("https://slack.com/api/chat.postMessage",
                               body: body,
                               headers: { "Content-Type" => "application/x-www-form-urlencoded" })

      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when posting #{text} to #{name}, error: #{response.parsed_response["error"]}"
      end

      return response.code == 200 && response.parsed_response["ok"]
    end

    def self.load
      raise NotImplementedError
    end
    
    def details
      raise NotImplementedError
    end

    def self.list
      raise NotImplementedError
    end

  end

end