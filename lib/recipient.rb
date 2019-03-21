require "httparty"
require "dotenv"
require "awesome_print"
require "pry"
require_relative "channel"
require_relative "user"

module Slack
  class Recipient
    class SlackError < StandardError; end

    attr_reader :slack_id, :name

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end # initialize
  end # class
end # module
