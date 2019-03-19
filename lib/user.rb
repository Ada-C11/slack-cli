require "pry"

require_relative "recipient"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
  end

  def self.list
    raw_data = self.get("user")

    unless raw_data.code == 200
      raise SlackApiError, "Improper request: #{raw_data.message}"
    end

    puts raw_data
    user_list = []
    members = raw_data["members"]
    members.each do |member|
      slack_id = member["id"]
      name = member["name"]
      real_name = member["real_name"]
      status_text = member["status_text"]
      status_emoji = member["status_emoji"]

      user = User.new(slack_id, name, real_name, status_text, status_emoji)
      user_list << user
    end
    return user_list
  end
end

# binding.pry
# self.list
