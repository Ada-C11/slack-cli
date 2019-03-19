require "httparty"
require "dotenv"
Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  def initialize
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
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
