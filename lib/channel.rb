require_relative "recipient"

class Channel < Recipient
  attr_reader
  LIST_URL = "https://slack.com/api/channels.list"

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
    query_params = {
      token: TOKEN,
    }
    response = Channel.get(query: query_params)
    return response
  end

  def details
  end
end

# test = Channel.list
