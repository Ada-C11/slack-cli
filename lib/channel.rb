module SlackBot
    class Channel < Recipient
      CHANNEL_LIST_URL = "https://slack.com/api/channels.list?"
      TOKEN = ENV["TOKEN"]
      def self.list
        query_parameters = { token: TOKEN }
        response = HTTParty.get(CHANNEL_LIST_URL, query: query_parameters)
  
        channels_array = response["channels"].map do |channel|
          {
            num_members: channel["num_members"],
            name: channel["name"],
            slack_id: channel["id"],
          }
        end
        return channels_array
      end
    end
  end
  