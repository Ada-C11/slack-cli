# workspace

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = users,
    @channels = channels,
    @selected = selected
  end

  def select_channel(channel)
    # takes channel as user input
  end

  def select_user(user)
    # takes user as user input
  end

  def show_details(selected_item)
    # show details of either user/channel
  end

  def send_message(selected_item)
    # send a message to either user/channel
  end
end