module Slack
  class SlackError < Exception; end

  module ApiWrapper
    def self.get_channels
    end
    URL_BASE = "https://slack.com/api/"

    def self.get_users
      users = []
      return users
    end

    private

    def self.get_json(url_tail:, query_params:)
      response = HTTParty.get(make_url(url_tail: url_tail), query: query_params)
      if !response["ok"]
        raise SlackError.new
      end
      return response
    end

    def self.make_url(url_tail:)
      return URL_BASE + url_tail
    end
  end
end
