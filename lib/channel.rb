require "httparty"

class Channel < Recipient
  BASE_URL = "https://slack.com/api/channels.list"
  TOKEN = ENV["SLACK_TOKEN"]

  class SlackAPIError < StandardError; end

  def initialize(slack_id, name, topic, member_count)
    super
    @topic = topic
    @member_count = member_count
  end

  def details
  end

  def get_channels(workspace)
    query_params = {
      workspace: workspace,
      token: TOKEN,
      format: json,
    }
    response = HTTParty.get(BASE_URL, query: query)

    if response.code != 200 || response == nil
      raise SlackAPIError, "API call failed with code #{response.code} and reason '#{response["reason"]}"
    end

    channel = response["response"].map do |channel|
      self.new(channel["id"], channel["name"], channel["topic"], channel["members"])
    end
  end

  def self.list
  end
end
