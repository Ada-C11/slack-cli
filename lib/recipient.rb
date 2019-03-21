require "httparty"
require "dotenv"

Dotenv.load

module SlackApi
  BASE_URL = "https://slack.com/api/chat.postMessage"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  class SlackApiError < StandardError; end

  def self.send_message(message, user)
    #   user_id = User.list.each do |id|
    #     if user == id[0]
    #       user[2]
    #     end
    #   end

    # have two responses if select is a type of user choose 1st response
    # else if user input is a type of channel choose 2nd response. the channel can be select_user or select_channel from the main
    # we'd have to require workspace

    response = HTTParty.post(
      "#{BASE_URL}",
      headers: {"Content-Type" => "application/x-www-form-urlencoded"},
      body: {
        token: SLACK_TOKEN,
        text: message,
        channel: user_id, #.select_user(chose_user)
        as_user: true,
      },
    )

    if response["ok"]
      return true
    else
      raise SlackApi::SlackApiError, "Error when posting #{message} to #{user}, error: #{response["error"]}"
    end
  end
end
