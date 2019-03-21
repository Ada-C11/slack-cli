module SlackCLI
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @name = name
      @slack_id = slack_id
    end

    def self.get(url, params)
      return HTTParty.get(url, query: params)
    end

    def display_details
      raise NotImplementedError, "Implement me in a child class!"
    end

    def self.get_from_api
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end
