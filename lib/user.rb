# require_relative "slack"
require "httparty"
require "dotenv"
require "table_print"
Dotenv.load

class User
  attr_reader :user_name, :user_id, :real_name

  def initialize(user_name, user_id, real_name)
    @user_name = user_name
    @user_id = user_id
    @real_name = real_name
  end

  def details
    puts "
    Name: #{user_name}
    ID: #{user_id}
    Real Name: #{real_name}
    ---"
  end
end
