
class User < Recipient
  BASE_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_TOKEN"]

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
  end

  def self.list
  end
end
