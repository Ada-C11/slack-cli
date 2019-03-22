require "httparty"
require "pry"

require "dotenv"
Dotenv.load

module SlackCli
  class SlackError < StandardError; end

  class Recipient
    MSG_URL = "https://slack.com/api/chat.postMessage"
    TOKEN = ENV["SLACK_TOKEN"]

    attr_reader :send_message, :name, :slack_id, :error_helper, :details, :list
    # :nocov:
    def initialize
      @slack_id = slack_id
      @name = name
    end
    # :nocov:

    def self.list_url
      raise NotImplementedError, "TODO: implement me in a child class"
    end

    def post_message(name, message)
      body_params = {
        token: TOKEN,
        as_user: true,
        channel: name,
        text: message,
      }
      response = HTTParty.post(MSG_URL, body: body_params)

      if response != 200 && !response["ok"]
        raise SlackCli::SlackError "Error: #{response["error"]}"
      else
        return response
      end
    end

    def self.get
      query_params = {
        token: TOKEN,
      }
      response = HTTParty.get(list_url, query: query_params)
      return error_helper(response)
    end
    
    # :nocov:
    def details
      raise NotImplementedError "TODO: implement me in a child class"
    end

    def self.list
      raise NotImplementedError "TODO: implement me in a child class"
    end
    # :nocov:

    def self.error_helper(response)
      unless response.code == 200 && response["ok"]
        raise SlackError, "Error #{response.code}: #{response["error"]}"
      end
      return response
    end
  end
end
