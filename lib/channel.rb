require_relative "recipient"

class Channel < Recipient
  attr_reader
  CHANNEL_URL = "https://slack.com/api/channels.list"

  def initialize
    @topic
    @member_count
  end

  def self.list
    # calls the self.get method from parent
    # retrieves the channel payload
    # iteratest through the channel payload
    # and displays list of channel names to the CLI
    # as an array
    params = {
      token: TOKEN,
    }
    response = Channel.get(CHANNEL_URL, query: params)
    return response
  end

  def details
  end
end

test = Channel.list
