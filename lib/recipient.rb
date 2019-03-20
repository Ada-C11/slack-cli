module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    def send_message(message)
      # Implement here.
    end

    def self.get(url)
      response = HTTParty.get(
        url,
        query: {
          token: ENV["SLACK_API_TOKEN"],
        },
      )

      if response.code == 200
        return response
      else
        raise ArgumentError, "Error: #{response.code} #{response.message}" # change this to a better error response
      end

      return response.parsed_response
    end

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end

    def details
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end
