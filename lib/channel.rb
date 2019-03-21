require "dotenv"
require "httparty"

Dotenv.load

module SlackApi
  class SlackError < StandardError; end

  class Channel #< Recipient
    def self.channel_api
      url = "https://slack.com/api/channels.list"
      key = ENV["SLACK_API_TOKEN"]
      parameters = {'token': key}
      response = HTTParty.get(url, query: parameters).to_s
      response = JSON.parse(response)

      return response["channels"]
    end

    def self.send_message(message, recipient)
      url = "https://slack.com/api/"
      key = ENV["SLACK_API_TOKEN"]

      response = HTTParty.post(
        "#{url}chat.postMessage",
        headers: {"Content-Type" => "application/x-www-form-urlencoded"},
        body: {
          token: key,
          text: message,
          channel: recipient,
        },
      )
      if response["ok"]
        return true
      else
        raise SlackApi::SlackError, "Error when posting message to #{response[:body][:channel]}, error: #{response["error"]}"
      end
    end

    def self.list(channels_list)
      puts "\nHere are a list of your channels for this Workspace:"
      list_of_channels = channels_list.map do |channel|
        "\nChannel name: #{channel["name"]}\nSlack ID: #{channel["id"]}\nTopic: #{channel["topic"]["value"]}\nMember count: #{channel["num_members"]}\n"
      end
      return list_of_channels
    end
  end
end
