require "pry"
require "httparty"

class User < Recipient
  attr_reader :real_name

  def initialize(real_name)
    @real_name = real_name
  end

  def self.list
    response = self.get("channels.list")
    response.map do
      self.new
    end
  end
end
