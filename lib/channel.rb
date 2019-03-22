module SlackBot
  class Channel < Recipient
    CHANNEL_PATH_URL = "channels.list?"
    #   TOKEN = ENV["TOKEN"]
    attr_reader :num_members, :name, :id

    def initialize(num_members:, name:, id:)
      @num_members = num_members
      @name = name
      @id = id
    end

    def self.list
      query_parameters = { token: TOKEN }
      response = HTTParty.get("#{BASE_URL}#{CHANNEL_PATH_URL}", query: query_parameters)
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when listing channels, error: #{response.parsed_response["error"]}"
      end

      channels_array = response["channels"].map do |channel|
        SlackBot::Channel.new(num_members: channel["num_members"], name: channel["name"], id: channel["id"])
      end

      return channels_array
    end

    def details
      channel_details = {
        num_members: @num_members,
        name: @name,
        id: @id,
      }
      return channel_details
    end
  end
end
