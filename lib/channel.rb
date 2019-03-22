require 'dotenv'
require 'httparty'
require 'table_print'
require_relative 'recipient'
Dotenv.load

module SlackAPI
  class Channel < Recipient
        
  attr_reader :topic, :member_count

  URL = "https://slack.com/api/channels.list"
  TOKEN = ENV['TOKEN']
  @@all = []

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: slack_id, name: name)
      @topic = topic
      @member_count = member_count
    end

    def details
    return "Channel name: #{name}
     Slack ID: #{slack_id}
     Topic: #{topic}
     Member count: #{member_count}"
    end

    def self.list
      return @@all
    end

    def self.load
      query_parameters = {
        token: TOKEN,
      }
      response = HTTParty.get(URL, query: query_parameters)['channels']
      response.each do |channel|
        topic = channel['topic']['value']
        member_count = channel['num_members']
        slack_id = channel['id']
        name = channel['name']
        new_channel = Channel.new(topic: topic, member_count: member_count, slack_id: slack_id, name: name)
        @@all << new_channel
      end
      return @@all
    end
  end
end