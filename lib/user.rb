require_relative "workspace"
require "httparty"
require "dotenv"
Dotenv.load

module SlackCLI
  USER_URL_MESSAGE = "https://slack.com/api/"
  API_KEY = ENV["SLACK_API_TOKEN"]

  class User
    attr_reader :name, :real_name, :id

    def initialize(name, real_name, id)
      @name = name
      @id = id
      @real_name = real_name
    end

    def self.get(url, param)
      query = {token: param}
      response = HTTParty.get(url, query: query)
      return response
    end

    def self.list(url, param)
      response = self.get(url, param)
      members = response["members"]
      formatted_list = []
      members.each do |member|
        name = member["name"]
        real_name = member["real_name"]
        id = member["id"]
        formatted_list << self.new(name, real_name, id)
      end
      return formatted_list
    end

    def self.details(user, url, param)
      formatted_list = self.list(url, param)
      details_user = ""
      formatted_list.each do |member|
        if member.name == user || member.id == user
          details_user = "\n\nUSER'S DETAILS:
            Name: #{member.name}
            Real name: #{member.real_name}
            Id: #{member.id}"
          return details_user
        end
      end
      raise ArgumentError, "The user you are trying to find does not exist"
    end

    def self.message(text, user)
      response = HTTParty.post(
        "#{USER_URL_MESSAGE}chat.postMessage",
        headers: {"Content-Type" => "application/x-www-form-urlencoded"},
        body: {
          token: API_KEY,
          channel: user,
          text: text,
        },
      )
      if response["ok"]
        return true
      else
        raise ArgumentError, "Error when sending  message to #{user}."
      end
    end
  end
end