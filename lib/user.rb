require "httparty"
require "env"
Dotenv.load

class User
  attr_reader :user_name, :real_name, :slack_id

  def initialize
    @user_name = user_name
    @real_name = real_name
    @slack_id = slack_id
  end

  def details
  end

  def self.list
  end
end
