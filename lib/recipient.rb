require "pry"
require "httparty"

class Recipient
  BASE_URL = "https://slack.com/api/"

  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    raise ArgumentError if !name.is_a? String

    @name = name
  end

  private

  def self.get(endpoint, params = {})
    url = BASE_URL + endpoint
    params[:token] = ENV["SLACK_API_TOKEN"]
    HTTParty.get(url, query: params)
  end

  def self.list
    raise NotImplementedError, "Implement me in a child class!"
  end
end
