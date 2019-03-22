require "dotenv"
require "httparty"
require_relative "user"
require_relative "channel"
Dotenv.load

class Workspace
  attr_reader :user, :channel
  attr_accessor :selected

  class SlackApiError < StandardError; end

  def select_channel(selected)
    selected
  end

  def select_user(selected)
    selected
  end

  def show_details(selected)
    user_name = User.list.map do |user|
      user[0]
    end
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
end
