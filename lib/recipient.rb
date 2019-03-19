module Slack
  class Recipient 
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    # Implemented
    def send_message(message)

    end

    def self.get(url, params)

    end

    private
    # abstract
    
    def details

    end

    def self.list

    end

  end

end
