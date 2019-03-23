require 'table_print'
require "httparty"
require "dotenv"

class Channel
  attr_reader :name, :id, :topic, :member_count
  # @topic = topic
  # @member_count = member_count

  def initialize(channel_map)
    @id = channel_map['id']
    @topic = channel_map['topic']['value']
    @member_count = channel_map['num_members']
    @name = channel_map['name']
  end

  # def details
  #   return "slack id: #{@id} #{@topic} member count: #{@member_count}"
  # end

  def to_s
    "Name:#{@name},Topic:#{@topic},Member count :#{@member_count},Slack ID: #{@id}"
  end
end
