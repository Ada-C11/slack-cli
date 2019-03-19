class Recipient
  def initialize
    @name = name
    @slack_id = slack_id
  end

  def self.list
    # return all instances of the recipient (either Users or Channels)
  end

  def self.get(url, parameters)
    # call the API to return information
    response = HTTParty.get(url, query: parameters)
  end
end
