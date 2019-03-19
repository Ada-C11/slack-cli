module SlackBot
    class Workspace
        attr_reader :users, :channels
        def initialize
            @users = SlackBot::User.list
            @channels = SlackBot::Channel.list
        end
    end
end