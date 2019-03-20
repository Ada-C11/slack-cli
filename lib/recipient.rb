module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    # def self.get
    #   puts "Every subclass of Recipient will get here when you call the get method"
    #   HTTParty.GET(url, query: params)
    #   return "Dee is writing something specific >:)"
    # end

    # def self.list_all
    #   raise NotImplementedError, "Please implement in my child."
    # end
  end
end
