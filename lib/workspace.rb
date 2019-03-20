require "dotenv"
require "httparty"
require_relative "user"
require_relative "channel"
Dotenv.load

class Workspace
  attr_reader :user, :channel
  attr_accessor :selected

  # USER_URL = "https://slack.com/api/users.list"
  # SLACK_TOKEN = ENV["SLACK_TOKEN"]

  # CHANNEL_URL = "https://slack.com/api/channels.list"
  # SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def initialize
    @user = []
    @channel = []
    @selected = selected
  end

  class SlackApiError < StandardError; end

  def select_channel(selected)
    #Channel.list
    #using param, find specific channel
    # returns an instance of channel

    # selected = Channel.new
    # Channel.list.each do |instance|
    #   if selected == instance[0]
    #     return instance
    #   end
    # end

    selected
  end

  def select_user(selected)
    #User.list
    #using param, find specific user
    # returns an instance of user
    # User.list.each do |instance|
    #   if selected == instance[0]
    #     return instance
    #   end
    # end
    # selected = User.new

    selected
  end

  # seperate methods for Channel and User
  def show_details(selected)
    # array of all user names
    user_name = User.list.map do |user|
      user[0]
    end
    # array of all channel names
    channel_name = Channel.list.map do |channel|
      channel[0]
    end
    if channel_name.include?(selected)
      Channel.list.each do |instance|
        if selected == instance[0]
          return instance
        end
      end
    elsif user_name.include?(selected)
      User.list.each do |instance|
        if selected == instance[0]
          return instance
        end
      end
    end

    if selected == ""
      raise SlackApiError, "No user of channel was selected!"
    end
  end

  # def show_details_user(selected)
  #   #something users
  #   User.list.each do |instance|
  #     if selected == instance[0]
  #       return instance
  #     end
  #   end
  # end

  def send_message
  end
end
