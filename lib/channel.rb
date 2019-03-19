module SlackAPI
  class Channel
        
  attr_reader :topic, :member_count

    def initialize(topic:, member_count:)
      super(slack_id:, name:)
      @topic = topic
      @member_count = member_count
    end

    def details
    end

    def self.list
      channel_names = []
      query_parameters = {
        token: ENV['TOKEN'],
      }
      channels = HTTParty.get(BASE_URL << CHANNELS_LIST_PATH, query: query_parameters)['channels']
      channel_names = channels.map do |channel|
      channel['name']
      end
      return channel_names
    end
  end
end