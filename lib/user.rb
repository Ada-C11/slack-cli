require "httparty"
require "dotenv"
Dotenv.load

class User
  attr_reader :user_name, :real_name, :slack_id

  BASE_URL = "https://slack.com/api/users.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]
  # query_param = {
  #   token: SLACK_TOKEN,
  # }
  # response = httparty.get(BASE_URL, query: query_param)

  def initialize
    @user_name = user_name
    @real_name = real_name
    @slack_id = slack_id
  end

  # def get_user
  #   query_param = {
  #     token: SLACK_TOKEN,
  #   }
  #   response = httparty.get(BASE_URL, query: query_param)
  #   return response
  # end

  def details
  end

  def self.list
    #access the response/API above
    # look inside response["members"]
    # return username, real name, and slack ID

    query_param = {
      token: SLACK_TOKEN,
    }
    response = HTTParty.get(BASE_URL, query: query_param)

    list = []
    response["members"].each do |member|
      member_info = []
      member_info << member["name"]
      member_info << member["real_name"]
      member_info << member["id"]

      list << member_info
    end

    # list is an array of arrays
    return list
  end
end
