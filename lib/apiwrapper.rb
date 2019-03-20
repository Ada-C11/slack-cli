module Slack
  module ApiWrapper
    def self.get_channels
    end

    def self.get_users
      users = []
      return users
    end

    def self.get_json(url:, query_params:)
      response = HTTParty.get(url, query: query_params)
      
      return response
    end
  end
end
