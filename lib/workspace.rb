module SlackAPI

    class Workspace

        attr_accessor :selected

        attr_reader :users, :channels

        def initialize(users:, channels:, selected:)
             @users = users
             @channels = channels
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

end