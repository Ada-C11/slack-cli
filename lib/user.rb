require "httparty"
require "pry"
require_relative "recipient.rb"
require_relative "slack_api_error.rb"

class User < Recipient
  attr_reader :real_name

  def initialize(slack_id:, name:, real_name:)
    super(slack_id, name)
    @real_name = real_name
  end

  def self.list
    response = self.get("users.list")
    users = response["members"].map do |member|
      self.create_from_api_response(member)
    end
    return users
  end

  private

  # Stays in User
  def self.create_from_api_response(member)
    name = member["name"]
    real_name = member["real_name"]
    slack_id = member["id"]

    return self.new(slack_id: slack_id, name: name, real_name: real_name)
  end
end # end User class
