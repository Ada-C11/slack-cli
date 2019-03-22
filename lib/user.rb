require "pry"

module SlackBot
  # class SlackApiError < StandardError; end

  class User < Recipient
    USER_PATH_URL = "users.list?"
    # TOKEN = ENV["TOKEN"]
    attr_reader :real_name, :name, :id

    def initialize(real_name:, name:, id:)
      @real_name = real_name
      @name = name
      @id = id
    end

    def self.list
      query_parameters = { token: TOKEN }
      response = HTTParty.get("#{BASE_URL}#{USER_PATH_URL}", query: query_parameters)
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when listing users, error: #{response.parsed_response["error"]}"
      end
      users_array = response["members"].map do |user|
        SlackBot::User.new(real_name: user["real_name"], name: user["name"], id: user["id"])
      end

      return users_array
    end

    def details
      user_details = {
        real_name: @real_name,
        name: @name,
        id: @id,
      }
      return user_details
    end
  end
end
