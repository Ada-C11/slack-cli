require_relative "user"
require_relative "channel"

module SlackCLI
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = SlackCLI::User.list
      @channels = SlackCLI::Channel.list
      @selected = nil
    end

    def select_user(user_info)
      @selected = find_user(user_info)
    end

    private

    def find_user(user_info)
      @users.each do |user|
        if user_info == user.slack_id || user_info == user.name
          return user
        end
      end
      return nil
    end
  end
end
