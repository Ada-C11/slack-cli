module Slack
  class User < Recipient
    attr_reader :slack_id, :name, :url

    def initialize(slack_id, name)
      super(slack_id, name)
    end

    def self.get
      url = "https://slack.com/api/users.list"
      params = {
        token: ENV["KEY"],
      }

      response_from_get = HTTParty.get(url, query: params)

      return response_from_get
    end

    # def self.list_all

  end
end
