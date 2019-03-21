
require "httparty"
require "pry"
require_relative "recipient"
require "dotenv"
Dotenv.load

class User < Recipient
  BASE_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_TOKEN"]

  def initialize(id, name, real_name)
    super(id, name)
    @real_name = real_name
    @id = id
    @name = name

  end

  def self.list
    query_params = {
      token: TOKEN,
    }

    response = HTTParty.get(BASE_URL, query: query_params)

    unless response.code == 200
      raise SearchError, "Cannot find #{search_term}"
    end
    members_list = []
    members = response["members"]
    members.each do |member|
      id = member["id"]
      name = member["name"]
      real_name = member["real_name"]
      new_member = User.new(id, name, real_name)
      members_list << new_member
    end
    return members_list
  end
  def detail
    puts "#{real_name}, slack user name: #{name}, id: #{id}"
  end


end

# puts User.list
# puts User.list[0]
# #puts User.list
#  puts User.list["members"][0]["id"]
#  puts User.list["members"][0]["real_name"]
#  puts User.list["members"][0]["name"]