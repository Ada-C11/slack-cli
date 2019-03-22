require "httparty"
require_relative "../lib/user"
require_relative "../lib/channel"
require_relative "../lib/recipient"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize(selected:)
    @users = User.list
    @channels = Channel.list
    @selected = selected # either user or channel
  end

  # methods that initialize selected (either select_user or select_method)
  def select_user
    user_selected = users.detect do |user|
      user.slack_id == selected || user.name == selected
    end
    return user_selected
    #find @selected within @users info

  end

  def select_channel
    channel_selected = channels.detect do |channel|
      channel.slack_id == selected || channel.name == selected
    end
    return channel_selected
  end

  def send_message(message, recipient)
    params = {}
    params[:text] = message
    params[:channel] = recipient.slack_id
    p recipient.slack_id
    # params[:as_user] = true
    recipient.send_message(params)
  end

  #   def show_details
  #     user = select_user
  #     user.details #need to change details so that this produces a hash and can be pretty printed out here
  #   end
end
