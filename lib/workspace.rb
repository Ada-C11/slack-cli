require_relative "channel"
require_relative "user"
require_relative "recipient"
require "dotenv"
require "httparty"
require "pry"
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
      return Slack::Channel.list_all.map { |channel| channel.convert_to_string }
    end

    def self.select_channel(channel_identifier)
      find_channel = Slack::Channel.list_all.find do |channel|
        channel.name.downcase == channel_identifier.downcase ||
        channel.slack_id.downcase == channel_identifier.downcase
      end
      return find_channel
    end

    def self.selected_channel_details(chosen_channel)
      details = "Channel ID: #{chosen_channel.slack_id}\nChannel name: #{chosen_channel.name} \nMembers: #{chosen_channel.num_members} \nChannel Topic: #{chosen_channel.topic}"

      return details
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
        user.name.downcase == user_identifier.downcase ||
        user.slack_id.downcase == user_identifier.downcase
      }

      return find_user
    end

    def self.selected_user_details(chosen_user)
      details = "User ID: #{chosen_user.slack_id}: \nReal name: #{chosen_user.real_name} \nDisplay name: #{chosen_user.name}."
    end
  end
end
