require "pry"
require "dotenv"
require "httparty"
require "table_print"
require "terminal-table"

require_relative "user"
require_relative "channel"

module Slack
  class Workspace
    attr_accessor :selected
    attr_reader :users, :channels

    def initialize
      @users = Slack::User.list
      @channels = Slack::Channel.list
      @selected = nil
    end

    def select_channel(identifier)
      @selected = @channels.find do |channel|
        channel.slack_id == identifier || channel.name == identifier
      end
    end

    def select_user(identifier)
      @selected = @users.find do |user|
        user.slack_id == identifier || user.name == identifier
      end
    end

    def show_details
      details = @selected.details

      rows = []
      details.each do |key, details|
        rows << [key, details]
      end

      table = Terminal::Table.new :rows => rows
      return table
    end

    def send_message(input)
      @selected.send_message(input)
      # The user gives a message
      # This method enters user's message as an argument for Recipient's send_message

    end
  end
end
