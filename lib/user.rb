
require "httparty"
<<<<<<< HEAD
require "pry"
require_relative "recipient"
require "dotenv"
Dotenv.load
=======
require_relative "recipient"
>>>>>>> refs/remotes/origin/master

class User < Recipient
  BASE_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_TOKEN"]

<<<<<<< HEAD
  def initialize
=======
  def initialize(slack_id, name)
>>>>>>> refs/remotes/origin/master
    super
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list
    puts TOKEN
    query_params = {
      token: TOKEN,
    }

    response = HTTParty.get(BASE_URL, query: query_params)

    unless response.code == 200
      raise SearchError, "Cannot find #{search_term}"
     end
    # response.each do |response|
    #   puts "id: #{response.first["members"][0]}"
    # end
    return response
   end
end

#puts User.list
#binding.pry
#puts User.list
# puts User.list["members"][0]["id"]
# puts User.list["members"][0]["real_name"]