require "httparty"
require_relative "recipient"
require "dotenv"
Dotenv.load

class Channel < Recipient
  BASE_URL = "https://slack.com/api/channels.list"
  TOKEN = ENV["SLACK_TOKEN"]

  class SlackAPIError < StandardError; end

  def initialize
    super
    @topic = topic
    @member_count = member_count
  end

  def details
  end

  def self.list
    query_params = {
      token: TOKEN,
    }
    response = HTTParty.get(BASE_URL, query: query_params)
    # responses = response["response"]

    # if response.code != 200 || response == nil
    #   raise SlackAPIError
    # end

    # responses.each do |pass|
    #   puts "#{pass["topic"].to_s}"
    #   puts "#{pass["members"].to_a}"
    # end
  end
end

# puts Channel.list

# , "API call failed with code #{response.code} and reason '#{response["reason"]}"
