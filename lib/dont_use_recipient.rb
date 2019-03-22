require "httparty"
require "dotenv"
Dotenv.load

class Recipient
  attr_reader :slack_id, :name
  BASE_URL = "https://slack.com/api/chat.postMessage"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def initialize(slack_id)
    @slack_id = slack_id
    @name = name
  end

  # class SlackApiError < StandardError
  #   raise SlackApiError, "This id does not exist"
  # end

  def send_message(message, user: true)
    SlackApi::self_message(message, slack_id)
    # query_param = {
    #   token: SLACK_TOKEN,
    #   channel: slack_id,
    #   text: message,
    #   as_user: user,
    # }

    # response = HTTParty.post(
    #   "#{BASE_URL}",
    #   body: {
    #     token: SLACK_TOKEN,
    #     text: message,
    #     channel: slack_id,
    #   },
    # )

    # if !response.code == 200 && response.parsed_response["ok"]
    #   raise SlackApiError, "Oops something went wrong"
    # end

    # return response.code == 200 && response.parsed_response["ok"]

    # if response.code != 200 raise SlackApiError, "This user/channel does not exist"

  end

  def self.get(url, params)
    # SLACK_TOKEN = ENV["SLACK_TOKEN"]
    # param = {
    #   token: SLACK_TOKEN,
    # }
    # response = HTTParty.get(url, query: param)
  end

  private

  def details
  end

  def self.list
  end
end
