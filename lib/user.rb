require_relative "recipient"
require_relative "apiwrapper"

module Slack
  class User < Recipient
    attr_reader :real_name

    def initialize(id:, name:, real_name:)
      super(id: id, name: name)
      @real_name = real_name
    end

    def details
      return "Name: #{name}, \nReal Name: #{real_name}, \nID: #{id}"
    end

    def self.create_users
      users = []
      response = ApiWrapper::get_users
      response["members"].each do |user|
        users << self.new(id: user["id"],
                          name: user["name"],
                          real_name: user["real_name"])
      end
      return users
    end
  end
end
