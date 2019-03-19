require 'httparty'
require 'dotenv'

class Recipient

attr_reader :slack_id, :name

def initialize
  @slack_id
  @name
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