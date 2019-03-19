require 'pry'
require 'httparty'

class User < Recipient
  attr_reader :real_name

  def initialize(real_name)
    @real_name = real_name
  end
end
