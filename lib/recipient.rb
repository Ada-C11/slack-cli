class Recipient 
  attr_reader :slack_id, :name
  def initialize(slack_id, name)
    @slack_id = slack_id 
    @name = name 
  end

  channel_url = 'https://slack.com/api/channels.list'
  user_url = 'https://slack.com/api/users.list'

  params = {
    token = ENV["SLACK_API_TOKEN"]
  }
  def self.get(url, params)
    response = HTTParty.get(url, query:params)
  end

  def send_message(message)
    response = HTTParty.post(url, message?)
  end
  private
  def details 
    raise NotImplementedError, "Implement this in the child class."
  end
  def self.list
    raise NotImplementedError, "Implement this in the child class."
  end
end