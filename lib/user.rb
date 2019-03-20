require "pry"
require "httparty"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text: nil, status_emoji: nil)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list
    response = self.get("users.list")
    user_list = []
    response["members"].each do |member|
      real_name = member["real_name"]
      status_text = member["profile"]["status_text"]
      status_emoji = member["profile"]["status_emoji"]
      # response.map do

      user_list << self.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji)
    end
    return user_list
  end
end
