require "httparty"
require "pry"
require_relative "recipient"
require "dotenv"
Dotenv.load

class User < Recipient
  attr_reader :real_name, :name, :slack_id

  def initialize(slack_id, name, real_name)
    super(slack_id, name)
    @real_name = real_name
    @slack_id = slack_id
    @name = name
  end

  def self.list
    raw_data = self.get("user")

    unless raw_data.code == 200
      raise SlackApiError, "Improper request: #{raw_data.message}"
    end
    members_list = []
    members = raw_data["members"]
    members.each do |member|
      slack_id = member["id"]
      name = member["name"]
      real_name = member["real_name"]
      new_member = User.new(slack_id, name, real_name)
      members_list << new_member
    end
    return members_list
  end

  def detail
    return "#{real_name}, slack user name: #{name}, slack_id: #{slack_id}"
  end
end
puts User.list