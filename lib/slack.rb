require "httparty"
require "dotenv"
require_relative "./user"
require_relative "./channel"


response = HTTParty.get('https://slack.com/api/channels.list?token=xoxp-my-great-key&pretty=1')
puts response.body, response.code, response.message, response.headers.inspect

https://slack.com/api/channels.list?token=xoxp-my-great-key&pretty=1
class Slack
  include HTTParty
  base_uri 'slack.com/api'

  def initialize(api_token)
    @options = { query: { token: api_token, pretty: 1 } }
  end

  def channels
    response = self.class.get("/channels.list", @options).parsed_response
    raise 'Failed to get channels' unless response['ok']
    channels = response['channels'].map { |channel_map|
      Channel.new(channel_map)
    }
    return channels
  end

  def users
    response = self.class.get("/users.list", @options).parsed_response
    raise 'Failed to get users' unless response['ok']
    users = response['members'].map { |user_map|
      User.new(user_map)
    }
    return users
  end

end
