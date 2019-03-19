require "pry"
require "httparty"

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    raise ArgumentError if !name.is_a? String

    @name = name
  end

  def self.get(url, params)
    response = HTTParty.get(url, query: params)
  end
end
