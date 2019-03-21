require_relative "workspace"
require "httparty"
require "dotenv"
Dotenv.load

module SlackCLI
  USER_URL_MESSAGE = "https://slack.com/api/"
  API_KEY = ENV["SLACK_API_TOKEN"]

  class User
    attr_reader :name, :id, :real_name

    def initialize(name, id, real_name)
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
      @formatted_list = []
      members.each do |member|
        name = member["name"]
        real_name = member["real_name"]
        id = member["id"]
        @formatted_list << self.new(name, id, real_name)
      end
      return @formatted_list
    end

    def self.details(parameter_to_find)
      details_user = ""
      @formatted_list.each do |member|
        if member.name == parameter_to_find || member.id == parameter_to_find
          details_user = "USER'S DETAILS:
            Name: #{member.name}
            Id: #{member.id}
            Real name: #{member.real_name}."
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
