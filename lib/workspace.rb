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
        "Channel ID: #{channel.slack_id}\nChannel name: #{channel.name} \nMembers: #{channel.num_members} \nChannel Topic: #{channel.topic}"
      end
      return channels
    end

    def self.select_channel(channel_identifier)
      find_channel = Slack::Channel.list_all.find do |channel|
        channel.name == channel_identifier ||
        channel.slack_id == channel_identifier
      end
      # put some sort argument error here?
      return find_channel
    end

    def self.selected_channel_details(channel_identifier)
      chosen_channel = self.select_channel(channel_identifier)

      details = "Channel ID: #{chosen_channel.slack_id}\nChannel name: #{chosen_channel.name} \nMembers: #{chosen_channel.num_members} \nChannel Topic: #{chosen_channel.topic}"

      return details

      # chosen_channel = self.select_channel(channel_identifier)

      # details = chosen_channel.self.all_channels_details
      # return details
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
        "User ID: #{user.slack_id}: \nReal name: #{user.real_name} \nDisplay name: #{user.name}."
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

# put Slack::Workspace.selected_channel_details("CH2NW42JF")
