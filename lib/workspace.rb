require 'httparty'
require 'dotenv'
require_relative './user'
require_relative './channel'

# response = HTTParty.get('https://slack.com/api/channels.list?token=xoxp-my-great-key&pretty=1')
# puts response.body, response.code, response.message, response.headers.inspect

# https://slack.com/api/channels.list?token=xoxp-my-great-key&pretty=1
class Workspace
  include HTTParty
  base_uri 'slack.com/api'

  def initialize(api_token)
    @options = { query: { token: api_token, pretty: 1 } }
  end

  def channels
    response = self.class.get('/channels.list', @options).parsed_response
    raise 'Failed to get channels' unless response['ok']

    channels = response['channels'].map do |channel_map|
      Channel.new(channel_map)
    end
    channels
  end

  def users
    response = self.class.get('/users.list', @options).parsed_response
    raise 'Failed to get users' unless response['ok']

    users = response['members'].map do |user_map|
      User.new(user_map)
    end
    users
  end

  def select_channel(selected_channel)
    channels.each do |channel|
      if channel.name == selected_channel || channel.id == selected_channel
        @selected = channel
        return channel
      end
    end
    nil
  end

  def select_user(selected_user)
    users.each do |user|
      if user.username == selected_user || user.id == selected_user
        @selected = user
        return user
      end
    end
    nil
  end

  # def show_details(details)
  #   #code
  # end

  # def send_message
  #   #code
  # end
end
