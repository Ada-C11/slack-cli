# require "httparty"
# require "dotenv"
# Dotenv.load

module SlackAPI
  class Recipient
    BASE_URL = "https://slack.com/api/"

    # def initialize(sub_url)
    #   @sub_url = sub_url
    # end

    def self.get(sub_url)
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }
      # puts sub_url

      response = HTTParty.get("#{BASE_URL}#{sub_url}", query: query)

      return response
    end

    def send_msg(recipient, text)
      response = HTTParty.post("#{BASE_URL}chat.postMessage",
                               headers: {"Content-Type" => "application/x-www-form-urlencoded"},
                               body: {
                                 token: ENV["SLACK_API_TOKEN"],
                                 channel: recipient,
                                 text: text,
                               })

      if response["ok"] == false
        raise SlackAPI::SlackError, "Error when posting #{text} to #{recipient}, error #{response["error"]}"
      else
        return true
      end
    end
  end
end
