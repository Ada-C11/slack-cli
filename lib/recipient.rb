module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    # def self.get(url, params)
    #   HTTParty.GET(url, query: params)
    # end

    # def self.list_all
    #   raise NotImplementedError, "Please implement in my child."
    # end
  end
end
