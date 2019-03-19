module SlackAPI

    class User < Recipient

        attr_accessor :status_text, :status_emoji

        attr_reader :real_name

        def initialize(real_name:,slack_id:, name:)
            super(slack_id:, name:)
            @real_name = real_name
        end

        def self.list
            list = []
            BASE_URL = "https://slack.com/api/users.list"
            response = HTTParty.get(BASE_URL, query: query_parameters)
            query_parameters = {token: ENV['TOKEN']}
            response["members"].length times do |i|
                real_name = response["members"][i]["real_name"]
                slack_id = response["members"][i]["slack_id"]
                name = response["members"][i]["name"]
                new_user = User.new(real_name: real_name,slack_id: slack_id, name: name)
                list.push(new_user)
            end
            return list
        end


    end

end