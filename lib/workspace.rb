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

    def self.selected_all_channels
      channels = Slack::Channel.list_all.map do |channel|
        "Channel ID #{channel.slack_id}'s name is #{channel.name}. \nIt has #{channel.num_members} members.  \nThe topic for this channel is: #{channel.topic}."
      end
      return channels
    end

    def self.user_list_all
      users = Slack::User.list_all
      name_users = users.map do |user|
        user.name
      end
      return name_users
    end

    def self.selected_all_users
      users = Slack::User.list_all.map do |user|
        "User ID: #{user.slack_id}'s real name is #{user.real_name} and displace name is #{user.name}."
      end
      return users
    end
  end
end

# Slack::Workspace.selected_all_users
