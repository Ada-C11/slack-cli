require "dotenv"
Dotenv.load

class Workspace
  attr_reader :user, :channel
  attr_accessor :selected

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
    Channel.list.each do |instance|
      if selected == instance[0]
        return instance
      end
    end
  end

  def select_user(selected)
    #User.list
    #using param, find specific user
    # returns an instance of user
    User.list.each do |instance|
      if selected == instance[0]
        return instance
      end
    end
  end

  # seperate methods for Channel and User
  def show_details_channel(selected)
    # something that represents channel
    Channel.list.each do |instance|
      if selected == instance[0]
        return instance
      end
    end
  end

  def show_details_user(selected)
    #something users
    User.list.each do |instance|
      if selected == instance[0]
        return instance
      end
    end
  end

  def send_message
  end
end
