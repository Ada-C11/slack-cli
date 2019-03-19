module SlackAPI

    class User < Recipient

        attr_accessor :status_text, :status_emoji

        attr_reader :real_name

        def initialize(real_name:,slack_id:, name:)
            super(slack_id:, name:)
            @real_name = real_name
        end

        def self.list
        end


    end

end