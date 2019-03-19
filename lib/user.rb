require_relative "recipient"

module Slack
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji

    def initialize(slack_id, name, real_name, status_text, status_emoji)
      super(slack_id, name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    #temp
    def self.list
      list = []

      url = "https://slack.com/api/users.list"

      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get(url, query: query_parameters)

      if response.code == 200
        response.parsed_response["members"].each do |member|
          slack_id = member["id"]
          name = member["name"]
          real_name = member["real_name"]
          status_text = member["profile"]["status_text"]
          status_emoji = member["status_emoji"]

          list << Slack::User.new(slack_id, name, real_name, status_text, status_emoji)
        end
      else
        ap "#{response.code} #{response.message}"
      end
      return list
    end
  end
end
