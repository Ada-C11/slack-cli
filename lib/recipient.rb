require "httparty"
require "env"
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
  end

  private

  def details
  end

  def self.list
  end
end
