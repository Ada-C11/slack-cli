require 'dotenv'
require 'httparty'
require 'pry'
require 'table_print'
Dotenv.load

module SlackAPI
  class Channel
        
  attr_reader :slack_id, :name, :topic, :member_count

  BASE_URL = "https://slack.com/api/channels.list"
  TOKEN = ENV['TOKEN']
  @@channels = []

    def initialize(slack_id:, name:, topic:, member_count:)
      # super(slack_id, name)
      @slack_id = slack_id
      @name = name
      @topic = topic
      @member_count = member_count
    end

    def details
        return detail_hash = {slack_id: @slack_id, name: @name, topic: @topic, member_count: @member_count}
    end

    def self.list
      return @@channels
    end

    private
    def self.load
      query_parameters = {
        token: TOKEN,
      }
      response = HTTParty.get(BASE_URL, query: query_parameters)['channels']
      response.each do |channel|
        topic = channel['topic']['value']
        member_count = channel['num_members']
        slack_id = channel['id']
        name = channel['name']
        new_channel = Channel.new(topic: topic, member_count: member_count, slack_id: slack_id, name: name)
        @@channels << new_channel
      end
      return @@channels
    end
  end
end