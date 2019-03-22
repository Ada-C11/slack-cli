require "httparty"
require "dotenv"
Dotenv.load

class User
  BASE_URL = "https://slack.com/api/users.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def self.list
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

    return list
  end
end
