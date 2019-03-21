require "httparty"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize(users:, channels:, selected:)
    @users = User.list
    @channels = Channel.list
    @selected = selected #either user or channel
  end

  # methods that initialize selected (either select_user or select_method)
  def select_user
    #find @selected within @users info

  end

  def show_details
    user = select_user
    user.details #need to change details so that this produces a hash and can be pretty printed out here
  end
end
