require "httparty"
require "dotenv"

Dotenv.load

module SlackCLI
  class SlackApiError < Exception; end

  class Workspace
    attr_reader :users, :channels, :selected

    def initialize(users:, channels:)
      @users = users
      @channels = channels
    end

    def display_users
      return tp users, :name, :real_name, :slack_id
    end

    def display_channels
      return tp channels, :slack_id, :name, :members, :topic => { :width => 120 }
    end

    def select_user(name_or_id)
      @selected = users.find { |user| user.name == name_or_id }
      @selected ||= users.find { |user| user.slack_id == name_or_id }
      return selected
    end

    def select_channel(name_or_id)
      @selected = channels.find { |channel| channel.name == name_or_id }
      @selected ||= channels.find { |channel| channel.slack_id == name_or_id }
      return selected
    end

    def show_details(name_or_id)
      if users.find { |user| user.name == name_or_id } 
        
      elsif @channels.include?(name_or_id.class) 
        channel = channels.find { |channel| return channel if channel.name == name_or_id}
      end
    end
  end
end
