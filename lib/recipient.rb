# require "httparty"
# require "dotenv"
# Dotenv.load

module SlackAPI
  class Recipient
    BASE_URL = "https://slack.com/api/"

    # def initialize(sub_url)
    #   @sub_url = sub_url
    # end

    def self.get(sub_url)
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }
      # puts sub_url

      response = HTTParty.get("#{BASE_URL}#{sub_url}", query: query)

      return response
    end
  end
end
