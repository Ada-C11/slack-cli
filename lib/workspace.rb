require_relative "user"
require_relative "channel"
require_relative "slack"
require "dotenv"
require "httparty"
Dotenv.load

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected
  #   BASE_URL = "https://slack.com/api/channels.list"
  #   TOKEN = ENV["SLACK_API_TOKEN"]

  def initialize
    @users = users #User.list
    @channels = channels #Channel.list
    @selected = selected
  end

  def self.select_user(user)
    #selected_user = @users.find(user)
    #@selected = selected_user
  end

  def self.select_channel(channel)
    #selected_channel = @channels.find(channel)
    #@selected = channel
  end

  def self.show_details
    #format details for selected user/channel w/ table gem
  end

  def self.send_message
    # do a post request taking selected user as parameter
  end
end

# query = {
#     token: TOKEN,
#   }
#   channel_info = HTTParty.get(BASE_URL, query: query)
#   if channel_info["ok"] == false
#     raise ArgumentError, "The error code is #{channel_info.code} and the reason is: #{channel_info.message}"
#   else
#     channel_list = channel_info["channels"]
#     @channel_names = channel_list.map do |channel|
#       channel["name"]
#     end
#     return @channel_names
#   end
# end
