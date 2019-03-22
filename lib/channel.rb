require "dotenv"
require "httparty"

Dotenv.load

module SlackApi
  class SlackError < StandardError; end

  class Channel
    url = "https://slack.com/api/channels.list"
    key = ENV["SLACK_API_TOKEN"]

    def self.channel_api(url, key)
      parameters = { 'token': key }
      response = HTTParty.get(url, query: parameters).to_s
      response = JSON.parse(response)

      if response["ok"] == true
        return response["channels"]
      else
        raise SlackApi::SlackError, "Error with Channel API: #{response["error"]}"
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
