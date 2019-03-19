class Workspace
  attr_reader :user, :channel
  attr_accessor :selected

  def initialize
    @user = user
    @channel = channel
    @selected = selected
  end

  def select_channel
  end

  def select_user
  end

  def show_details
  end

  def send_message
  end
end
