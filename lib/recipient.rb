require "httparty"
require "pry"

require "dotenv"
Dotenv.load
 
module SlackCli
  class SlackError < StandardError; end

  class Recipient
    

    MSG_URL = "https://slack.com/api/chat.postMessage"
    LIST_URL = nil
    TOKEN = ENV["SLACK_TOKEN"]

    attr_reader :send_message, :name, :slack_id, :error_helper, :details, :list

    def initialize
      @slack_id = slack_id
      @name = name
    end

    def send_message(name, message)
      body_params = {
        token: TOKEN,
        as_user: true,
        channel: name,
        text: message,
      }
      response = HTTParty.post(MSG_URL, body: body_params)
      # error_helper(response)
      return response
    end

    def self.get
      query_params = {
        token: TOKEN,
      }
      response = HTTParty.get(self::LIST_URL, query: query_params)
      # error_helper(response)
      return response
    end

    #private
    def details
      raise NotImplementedError
    end

    def self.list
      raise NotImplementedError
    end

    def error_helper(response)
      unless response.code != 200 || !response["ok"]
        raise SlackError, "Error #{response.code}: #{response["error"]}"
      end
      return response
    end
  end
end
