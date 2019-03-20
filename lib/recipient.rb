module Slack
  class Recipient
    attr_reader :name, :id

    def initialize(name:, id:)
      @name = name
      @id = id
    end

    def details
      raise NotImplementedError.new
    end
  end
end
