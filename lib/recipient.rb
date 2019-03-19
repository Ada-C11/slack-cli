require 'HTTParty'
require 'pry'

class Recipient
  # constants
  MSG_URL = "https://slack.com/api/chat.postMessage"
  USER_URL = "https://slack.com/api/users.list"
  CHANNEL_URL = "https://slack.com/api/channels.list"

  attr_reader :send_message, :name, :slack_id

  def initialize
    @slack_id = slack_id 
    @name = name
  end 

  def self.send_message(name, message)
    # using HTTParty.post(MSG_URL, message, slack_id)
    query_params = {
      token: ENV["SLACK_TOKEN"],
      channel: name,
      text: message,
    }
    # send a message to a recipient that matches provided slack_id
    response = HTTParty.post(MSG_URL, query: query_params)
    
    binding.pry
    # return response message/code
    if response["ok"]
      return "#{response.code}: Message sent!"
    else 
      return "#{response.code}: Message failed :("
    end
  end
end

Recipient.send_message("everyone", "this is a string!")