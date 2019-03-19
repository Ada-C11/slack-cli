require_relative 'recipient'

module Slack
  class User < Recipient

    def initialize(real_name:, status_text:, status_emoji:)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    def details
      # list details for a specific user

    end

    def self.list
      # list of all users
    end
    




  


  end
end


# USER_URL = "https://slack.com/api/users.list"
# query_params = { token: ENV["SLACK_API_TOKEN"] }


