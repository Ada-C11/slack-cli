require_relative "channel"
require_relative "user"
require_relative "recipient"
require "dotenv"
require "httparty"
Dotenv.load

module Slack
  class Workspace
    def self.channel_list_all
      channels = Slack::Channel.list_all
      name_channels = channels.map do |channel|
        channel.name
      end
      return name_channels
    end

    def self.user_list_all
      users = Slack::User.list_all
      name_users = users.map do |user|
        user.name
      end
      return name_users
    end
  end
end

# test = Slack::Workspace.new.user_list_all
# puts test
