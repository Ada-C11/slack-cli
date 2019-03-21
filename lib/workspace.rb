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

    def self.all_channels_details
      channels = Slack::Channel.list_all.map do |channel|
        "Channel ID #{channel.slack_id}'s name is #{channel.name}. \nIt has #{channel.num_members} members.  \nThe topic for this channel is: #{channel.topic}."
      end
      return channels
    end

    def self.select_channel(channel_identifier)
      find_channel = Slack::Channel.list_all.find {
        |channel|
        channel.name == channel_identifier ||
        channel.slack_id == channel_identifier
      }

      return find_channel
    end

    def self.selected_channel_details
    end

    def self.user_list_all
      users = Slack::User.list_all
      name_users = users.map do |user|
        user.name
      end
      return name_users
    end

    def self.all_users_details
      users = Slack::User.list_all.map do |user|
        "User ID: #{user.slack_id}'s real name is #{user.real_name} and display name is #{user.name}."
      end
      return users
    end

    def self.select_user(user_identifier)
      find_user = Slack::User.list_all.find {
        |user|
        user.name == user_identifier ||
        user.slack_id == user_identifier
      }

      return find_user
    end
  end
end

# Slack::Workspace.selected_all_users
