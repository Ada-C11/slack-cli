require "pry"
require "httparty"

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id: nil, name: nil)
    @slack_id = slack_id
    @name = name
  end
end
