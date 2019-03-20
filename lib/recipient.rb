require 'httparty'
require 'dotenv'

class Recipient

attr_reader :slack_id, :username

def initialize(slack_id:, username:)
  @slack_id = slack_id
  @username = username
end

def send_message(message)
end

def self.get(url, params)
end

def details
end

def self.list
end

end