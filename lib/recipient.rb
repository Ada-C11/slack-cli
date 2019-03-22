require "httparty"
require "awesome_print"
require "dotenv"
Dotenv.load

module Slack
  class ResponseError < StandardError; end
  class Recipient
    BASE_URL = "https://slack.com/api/chat.postMessage"
    
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
      # raise error here if name isn't a string
    end
  
    def self.get(base_url, parameters)
      response = HTTParty.get(base_url, query: parameters)
      # unless response.code == 200 && response.parsed_response["ok"]
      #   raise SlackError, response["error"]
      # end

      return response
    end

    def send_message(channel, text)
      message_request = HTTParty.post(BASE_URL,
        headers: {"Content-Type" => "application/x-www-form-urlencoded"},
        body: {
          token: ENV["SLACK_API_TOKEN"],
          channel: channel,
          text: text,
          # as_user: true,
        },
      )
  
      if message_request["ok"]
        return true
      else 
        raise ResponseError, "There was an error sending your message"      end
    end

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end

    def details
      ["name", "slack_id"]
    end
  end # class
end # module
