require_relative "slack"
require_relative "top"
require "httparty"
require "dotenv"
require "table_print"
Dotenv.load

class User
  attr_reader :topic, :member_count, :ch_name

  def lists_users
    @users["members"].each do |x|
      puts x["name"]
    end
  end
end
