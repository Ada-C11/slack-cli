module Slack
  class User < Recipient
    attr_reader :real_name

    def initialize(id:, name:, real_name:)
      super(id: id, name: name)
      @real_name = real_name
    end

    def details
      return ""
    end
  end
end
